import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:platform/platform.dart';

MethodChannel channel = MethodChannel('jmessage_flutter');
JmessageFlutter JMessage = JmessageFlutter();

typedef LoginCallback = void Function(bool isSuccess);

class JMessageManagerProvider with ChangeNotifier {
  // final JPush jpush = JPush();

  initPushMessage() async {
  //   jpush.getRegistrationID().then((rid) {});

  //   jpush.setup(
  //     appKey: "",
  //     channel: "dev",
  //     production: false,
  //     debug: true,
  //   );

    // jpush.applyPushAuthority(NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // try {
    //   jpush.addEventHandler(
    //     onReceiveNotification: (Map<String, dynamic> message) async {
    //       print("flutter onReceiveNotification: $message");
    //     },
    //     onOpenNotification: (Map<String, dynamic> message) async {
    //       print("flutter onOpenNotification: $message");
    //     },
    //     onReceiveMessage: (Map<String, dynamic> message) async {
    //       print("flutter onReceiveMessage: $message");
    //     },
    //   );
    // } on PlatformException {
    //   // platformVersion = 'Failed to get platform version.';
    // }

    JMessage.setDebugMode(enable: true);
    JMessage.init(
        isOpenMessageRoaming: true, appkey: '65e831cf441e2df70442995a',channel: 'test');
    JMessage.applyPushAuthority(
        JMNotificationSettingsIOS(sound: true, alert: true, badge: true));
  }

  juserLogin(LoginCallback callback, String jUserName, String jUserPWD) async {
    // await jmessage.login(
    //     username: jUserName, password: jUserPWD);
    // return loginResult(callback);
    JMessage.login(username: jUserName, password: jUserPWD).then((jUser) {
      callback(jUser != null);
    }).catchError((error) {});
  }

  loginResult(LoginCallback callback) async {
    JMUserInfo user = await JMessage.getMyInfo();
    print(user.toJson());
    return callback(user != null);
  }

  loginStatusChanged() async {
    JMessage.addLoginStateChangedListener((JMLoginStateChangedType type) {
      print('flutter receive event receive login state change $type');
      switch (type) {
        case JMLoginStateChangedType.user_login_status_unexpected:
          break;
        case JMLoginStateChangedType.user_disabled:
          break;
        case JMLoginStateChangedType.user_logout:
          break;
        default:
      }
    });
  }
}
