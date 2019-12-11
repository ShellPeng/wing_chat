import 'package:badges/badges.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wing_chat/provider/group_list_provider.dart';
import 'package:wing_chat/tools/app_toast.dart';
import 'package:wing_chat/views/chat/group_chat_scene.dart';
import 'package:wing_chat/views/chat/single_chat_scene.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class MessageListScene extends StatelessWidget {
  Widget _groupListCell(context, JMConversationInfo conversation) {
    String messageText = '';
    String title = '';
    var msgTime;
    var chatInfo;
    //如果该群组最近的一条消息对象不存在消息，则 conversation 对象中没有latestMessage该属性。
    if (conversation.latestMessage != null) {
      var lastMsg =
          JMNormalMessage.fromJson(conversation.latestMessage.toJson());
      msgTime = TimelineUtil.format(lastMsg.createTime,
          locale: DateTime.now().timeZoneName, dayFormat: DayFormat.Full);
    }
    if (conversation.conversationType == JMConversationType.group) {
      var chatInfo = JMGroupInfo.fromJson(conversation.target.toJson());
      title = chatInfo.name;
    } else {
      var chatInfo = JMUserInfo.fromJson(conversation.target.toJson());
      title = chatInfo.nickname;
    }

    if (conversation.latestMessage is JMTextMessage) {
      var textMsg = JMTextMessage.fromJson(conversation.latestMessage.toJson());
      messageText = textMsg.text;
    } else if (conversation.latestMessage is JMImageMessage) {
      messageText = '[图片]';
    } else {
      messageText = '欢迎加入群聊！';
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(18, 14, 15, 14),
              child: Badge(
                elevation: 0,
                showBadge: conversation.unreadCount != 0,
                badgeContent: Text(
                  '${conversation.unreadCount}',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage: AssetImage('images/dog.jpg'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$title',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    Text(
                      messageText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: Colors.black38, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              // color: Colors.pink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Text('创意与写作',style: TextStyle(color: AppColor.textColor,fontSize: 15,fontWeight: FontWeight.w500)),
                  Text(
                    '$msgTime',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (conversation.conversationType == JMConversationType.group) {
          chatInfo = JMGroupInfo.fromJson(conversation.target.toJson());
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      GroupChatScene(groupInfo: chatInfo))).then((value) {
            // Provider.of<GroupListProvider>(context).loginStatusCheck();
          });
        }else if(conversation.conversationType == JMConversationType.single) {
          
          chatInfo = JMUserInfo.fromJson(conversation.target.toJson());
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      SingleChatScene(userInfo: chatInfo))).then((value) {
            // Provider.of<GroupListProvider>(context).loginStatusCheck();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GroupListProvider()..loginStatusCheck()),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '消息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            // elevation: 0,
          ),
          backgroundColor: ThemeColor,
          body: Consumer<GroupListProvider>(builder: (_, provider, widget) {
            if (provider.groupList.length > 0) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _groupListCell(context, provider.groupList[index]);
                },
                itemCount: provider.groupList.length,
              );
            } else {
              return Container();
            }
          })),
    );
  }
}
