import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wing_chat/provider/jmessage_manager_provider.dart';

import 'views/root_scene.dart';
final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

void main(){
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    /// 等待sp初始化完成后再运行app。
    /// sp初始化时间 release模式下30ms左右，debug模式下100多ms。
    // await SpUtil.getInstance();
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
          builder: (_) => JMessageManagerProvider()..initPushMessage())
    ], child: MaterialApp(
                supportedLocales: [Locale('zh', ''), Locale('en', '')],
                title: 'Wing',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: Colors.white),
                home: RootScene(),
              )));
    
    // if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    // } else {
  });
}

