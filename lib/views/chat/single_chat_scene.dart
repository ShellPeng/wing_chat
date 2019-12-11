import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wing_chat/provider/single_chat_provider.dart';
import 'package:wing_chat/tools/expanded_viewport.dart';
final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class SingleChatScene extends StatelessWidget {
  final JMUserInfo userInfo;

  const SingleChatScene({Key key, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SingleChatProvider()
                ..context = context
                ..jmUserInfo = userInfo
                ..initConversation())
        ],
        child: Consumer<SingleChatProvider>(builder: (_, provider, widget) {
          return Scaffold(
            appBar: AppBar(title: Text('${userInfo.username}')),
            backgroundColor: Colors.white,
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
                onTap: () {// 触摸收起键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                  provider.emojiOpen = false;
                },
                child: SafeArea(
                  child: GroupChatList(),
                ),
            )
          );
        }));
  }
}

class GroupChatList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Consumer<SingleChatProvider>(builder: (_, provider, widget) {
      
      provider.keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      return Container(
        color: ThemeColor,
        child: Column(
        children: <Widget>[
          Expanded(
            child: SmartRefresher(
              controller: provider.controller,
              enablePullDown: false,
              enablePullUp: true,
              onLoading: () async {
                provider.getHistoryMessages();
              },
              footer: CustomFooter(
                  loadStyle: LoadStyle.HideAlways,
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading) {
                      return Container(
                        height: 60.0,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else
                      return Container();
                  }),
              child: Scrollable(
                controller: provider.scrollController,
                axisDirection: AxisDirection.up,
                viewportBuilder: (context, offset) {
                  return ExpandedViewport(
                    offset: offset,
                    axisDirection: AxisDirection.up,
                    slivers: <Widget>[
                      SliverExpanded(),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (c, i) => provider.chatWidgetChildren[i],
                            childCount: provider.chatWidgetChildren.length),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          GroupChatInput()
        ],
      ),
      );
    });
  }
}

class GroupChatInput extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<SingleChatProvider>(builder: (_, provider, widget) {
      
      return Container(
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Offstage(
                offstage: provider.talkFOT,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ThemeColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: ExtendedTextField(
                          specialTextSpanBuilder:
                              provider.mySpecialTextSpanBuilder,
                          controller: provider.textInputController,
                          focusNode: provider.fsNode,
                          // autofocus: true,
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            hintText: '请输入内容...',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(color: Colors.grey[400]),
                          ),
                          onChanged: (value) {
                            provider.reloadInputView();
                          },
                          onSubmitted: (value) {
                            provider.sendTextMessage(value);
                          },
                          onTap: () {
                            provider.emojiOpen = false;
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'images/chat_emoji.png',
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () {
                        provider.emojiOpen = !provider.emojiOpen;
                      },
                    ),
                    IconButton(
                      icon:
                          provider.textInputController.text.trim().length > 0 ||
                                  provider.emojiOpen
                              ? Text('发送')
                              : Image.asset(
                                  'images/chat_funcs.png',
                                  height: 24,
                                  width: 24,
                                ),
                      onPressed: () {
                        if (provider.textInputController.text.trim().length >
                                0 ||
                            provider.emojiOpen) {
                          provider.sendTextMessage(
                              provider.textInputController.text);
                          // provider.emojiOpen = false;
                        } else {
                          provider.sendImageMessage();
                        }
                      },
                    )
                  ],
                ),
              ),
              Offstage(
                  // 表情选择
                  offstage: !provider.emojiOpen,
                  child: Container(
                    height: provider.keyboardHeight,
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      children: provider.emojiArray.map((emojiName) {
                        return IconButton(
                          icon: Image.asset('emoji/$emojiName.png'),
                          onPressed: () {
                            provider.textInputController.text += emojiName;
                          },
                        );
                      }).toList(),
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1.0,
                    ),
                  ))
            ],
          ));
    });
  }
}

