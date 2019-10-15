import 'dart:io';
import 'dart:math';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
// import 'package:overseas_online/config/application.dart';
// import 'package:overseas_online/model/userinfo_model.dart';
// import 'package:overseas_online/view/group_chat/photo_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wing_chat/tools/special_text_span_builder.dart';
// import 'chat_report_provider.dart';
import 'jmessage_manager_provider.dart';

class GroupChatProvider with ChangeNotifier {
  bool isLoading = false;
  bool _talkFOT = false;
  bool _emojiOpen = false;
  double _keyboardHeight = 275.0;

  BuildContext context;
  FocusNode fsNode = FocusNode();
  TextEditingController textInputController = TextEditingController();
  ScrollController scrollController = ScrollController();
  RefreshController controller = RefreshController();
  PPSpecialTextSpanBuilder mySpecialTextSpanBuilder =
      PPSpecialTextSpanBuilder(type: BuilderType.extendedText);

  /// 聊天内容列表
  List<Widget> _chatWidgetChildren = <Widget>[];

  /// 聊天内容缓存列表
  List<PPMessageModel> _chatHistory = [];

  // UserInfoModel mySelf = UserInfoModel.fromJson(SpUtil.getObject("UserInfo"));

  JMGroup kGroup;
  JMGroupInfo kGroupInfo;
  JMConversationInfo kGroupConver;

  bool get talkFOT => _talkFOT;
  bool get emojiOpen => _emojiOpen;
  double get keyboardHeight => _keyboardHeight;

  /// 聊天内容列表
  List<Widget> get chatWidgetChildren => _chatWidgetChildren;

  /// 总消息数
  int totalMsgCount = 0;
  double extraHeight = 0;

  set talkFOT(value) {
    _talkFOT = value;
    notifyListeners();
  }

  set emojiOpen(value) {
    fsNode.unfocus();
    _emojiOpen = value;
    notifyListeners();
  }

  set keyboardHeight(value) {
    _keyboardHeight = max(_keyboardHeight, value);
    // notifyListeners();
  }

  reloadInputView() {
    notifyListeners();
  }

  List<String> emojiArray = [
    '[微笑]',
    '[撇嘴]',
    '[色]',
    '[发呆]',
    '[得意]',
    '[流泪]',
    '[害羞]',
    '[闭嘴]',
    '[睡]',
    '[大哭]',
    '[尴尬]',
    '[发怒]',
    '[调皮]',
    '[呲牙]',
    '[惊讶]',
    '[难过]',
    '[酷]',
    '[冷汗]',
    '[抓狂]',
    '[吐]',
    '[偷笑]',
    '[愉快]',
    '[白眼]',
    '[傲慢]',
    '[饥饿]',
    '[困]',
    '[惊恐]',
    '[流汗]',
    '[憨笑]',
    '[悠闲]',
    '[奋斗]',
    '[咒骂]',
    '[疑问]',
    '[嘘]',
    '[晕]',
    '[疯了]',
    '[衰]',
    '[骷髅]',
    '[敲打]',
    '[再见]',
    '[擦汗]',
    '[抠鼻]',
    '[鼓掌]',
    '[糗大了]',
    '[坏笑]',
    '[左哼哼]',
    '[右哼哼]',
    '[哈欠]',
    '[鄙视]',
    '[委屈]',
    '[快哭了]',
    '[阴险]',
    '[亲亲]',
    '[吓]',
    '[可怜]',
    '[菜刀]',
    '[西瓜]',
    '[啤酒]',
    '[篮球]',
    '[乒乓]',
    '[咖啡]',
    '[饭]',
    '[猪头]',
    '[玫瑰]',
    '[凋谢]',
    '[嘴唇]',
    '[爱心]',
    '[心碎]',
    '[蛋糕]',
    '[闪电]',
    '[炸弹]',
    '[刀]',
    '[足球]',
    '[瓢虫]',
    '[便便]',
    '[月亮]',
    '[太阳]',
    '[礼物]',
    '[拥抱]',
    '[强]',
    '[弱]',
    '[握手]',
    '[胜利]',
    '[抱拳]',
    '[勾引]',
    '[拳头]',
    '[差劲]',
    '[爱你]',
    '[NO]',
    '[OK]',
  ];

  /// 初始化数据
  initConversation() {
    kGroup = JMGroup.fromJson(
        {'type': JMGroupType.private, 'groupId': kGroupInfo.id});
    _createGroupConversation();
  }

  /// 创建会话
  _createGroupConversation() async {
    kGroupConver = await jmessage.createConversation(target: kGroup);

    jmessage.resetUnreadMessageCount(target: kGroup);

    await jmessage.enterConversation(target: kGroup);
    jmessage.addReceiveMessageListener((msg) async {
      print('消息监听++++++++++++++++++++++++++++++++++++++++');
      isLoading = false;
      if (kGroupConver.isMyMessage(msg)) {
        _parseMessage(msg, false);
      }
    });
    getHistoryMessages();
  }

  /// 获取历史消息
  getHistoryMessages() async {
    isLoading = true;
    var _historyList = await kGroupConver.getHistoryMessages(
        from: totalMsgCount, limit: 20, isDescend: true);
    if (_historyList == null) {
      // PPToast.show('没有更多历史消息');
      controller.loadNoData();
    } else {
      totalMsgCount += _historyList.length;
      _historyList.forEach((message) {
        _parseMessage(message, true);
      });
    }
  }

  /// 解析消息发送方
  JMUserInfo _parseOptUser(message, bool isHistory) {
    JMUserInfo optUser;

    if (message.target is JMGroupInfo) {
      optUser = message.from;
    } else if (message.target is JMUserInfo) {
      optUser = message.target;
    } else {}

    return optUser;
  }

  /// 消息解析
  _insertMsgToHistory(PPMessageModel messageModel, bool isHistory) {
    if (isHistory) {
      _chatHistory.insert(0, messageModel);
    } else {
      _chatHistory.add(messageModel);
    }
    _refreshMessageList(isHistory);
  }

  /// 消息解析
  _parseMessage(msg, bool isHistory) {
    if (msg is JMTextMessage) {
      JMTextMessage textMessage = JMTextMessage.fromJson(msg.toJson());
      JMUserInfo user = _parseOptUser(msg, isHistory);

      PPMessageModel msgModel = PPMessageModel()
        ..nickname = user.nickname
        ..userId = user.username
        ..avatar = user.extras['avatar']
        ..text = textMessage.text
        ..message = textMessage
        ..messageType = JMMessageType.text;

      _insertMsgToHistory(msgModel, isHistory);
    } else if (msg is JMImageMessage) {
      JMImageMessage imageMessage = JMImageMessage.fromJson(msg.toJson());
      JMUserInfo user = _parseOptUser(msg, isHistory);

      File imagefile = File('${imageMessage.thumbPath}');

      PPMessageModel msgModel = PPMessageModel()
        ..nickname = user.nickname
        ..userId = user.username
        ..avatar = user.extras['avatar']
        ..imageFile = imagefile
        ..message = imageMessage
        ..messageType = JMMessageType.image;

      _insertMsgToHistory(msgModel, isHistory);
    }
  }

  sendTextMessage(content) {
    kGroupConver.sendTextMessage(text: content).then((msg) {
      if (content != '' && content != null) {
        // _sendMessageContent(content, 'text');
        _parseMessage(msg, false);
        totalMsgCount += 1;
        textInputController.clear();
        notifyListeners();
      }
    }).catchError((error) {});
  }

  _refreshMessageList(bool isHistory) {
    List<Widget> widgetList = [];
    for (var i = 0; i < _chatHistory.length; i++) {
      widgetList.add(_layoutMessageCell(_chatHistory[i]));
    }
    // _chatWidgetChildren = widgetList;
    _chatWidgetChildren = widgetList.reversed.toList();
    controller.loadComplete();
    notifyListeners();
    jmessage.resetUnreadMessageCount(target: kGroup);

    if (!isHistory) {
      scrollController.animateTo(
        0.0,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void sendImageMessage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      kGroupConver.sendImageMessage(path: image.path).then((msg) async {
        _parseMessage(msg, false);
        totalMsgCount += 1;
      }).catchError((error) {});
    }
  }

  /// 根据消息类型加载消息内容
  _messageContentType(PPMessageModel msgModel, String otherId) {
    switch (msgModel.messageType) {
      case JMMessageType.image:
        return InkWell(
          onTap: () {
            jmessage
                .downloadOriginalImage(
                    messageId: Platform.isAndroid
                        ? msgModel.message.serverMessageId
                        : msgModel.message.id,
                    target: kGroup)
                .then((result) {
              if (result.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black,
                        child: ExtendedImage.file(
                        File(result['filePath']), fit: BoxFit.contain,
                        //enableLoadState: false,
                        mode: ExtendedImageMode.gesture,
                        onDoubleTap: (tap){
                          Navigator.pop(context);
                        },
                        initGestureConfigHandler: (state) {
                          return GestureConfig(
                              minScale: 0.9,
                              animationMinScale: 0.7,
                              maxScale: 3.0,
                              animationMaxScale: 3.5,
                              speed: 1.0,
                              inertialSpeed: 100.0,
                              initialScale: 1.0,
                              inPageView: false);
                        },
                      ),
                      ),
                      );
                    });
              }
            }).catchError((error) {
              print("下载出错：${error.toString()}");
            });
          },
          child: Image.file(
            msgModel.imageFile,
            height: 200 * 9 / 16.0,
            fit: BoxFit.fitWidth,
          ),
        );
        break;
      case JMMessageType.text:
        return ExtendedText(
          msgModel.text,
          style: TextStyle(
              color: msgModel.message.isSend ? Colors.white : Colors.black),
          specialTextSpanBuilder: mySpecialTextSpanBuilder,
        );
        break;
      default:
        break;
    }
  }

  _layoutMessageCell(PPMessageModel msgModel) {
    List<Widget> widgetList = [];
    var msgPadding;
    var msgMargin;
    var msgColor;

    if (msgModel.message.isSend) {
      msgMargin = EdgeInsets.only(right: 10, top: 10);
      msgColor = Colors.lightBlue;
    } else {
      msgMargin = EdgeInsets.only(left: 10, top: 10);
      msgColor = Colors.white;
    }

    if (msgModel.messageType == JMMessageType.image) {
      msgPadding = EdgeInsets.all(0);
      msgColor = Colors.transparent;
    } else {
      msgPadding = EdgeInsets.all(10.0);
    }

    Widget userAvatar = CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage('${msgModel.avatar}'),
    );

    Widget msgContent = Container(
        margin: msgMargin,
        padding: msgPadding,
        decoration: BoxDecoration(
            color: msgColor, borderRadius: BorderRadius.circular(10.0)),
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 120.0,
          child: _messageContentType(msgModel, msgModel.userId),
        ));

    if (msgModel.message.isSend) {
      widgetList = [msgContent, userAvatar];
    } else {
      widgetList = [userAvatar, msgContent];
    }

    return Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Row(
            mainAxisAlignment: msgModel.message.isSend
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetList));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    jmessage.exitConversation(target: kGroup);
    jmessage.removeReceiveMessageListener((message) {});
  }
}

class PPMessageModel {
  String nickname;
  String userId;
  String avatar;
  String text;
  File imageFile;
  JMNormalMessage message;
  JMMessageType messageType;

  PPMessageModel(
      {this.nickname,
      this.userId,
      this.avatar,
      this.text,
      this.imageFile,
      this.message,
      this.messageType});
}
