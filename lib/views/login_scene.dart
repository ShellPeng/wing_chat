import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wing_chat/provider/jmessage_manager_provider.dart';
import 'package:wing_chat/tools/app_toast.dart';
import 'package:wing_chat/tools/sp_util.dart';
import 'package:wing_chat/views/root_scene.dart';

class LoginPage extends StatelessWidget {
  // LoginPage({Key key}) : super(key: key);  
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Theme(
        data: ThemeData(primaryColor: Colors.lightBlue),
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Welcome Back!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 34,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              '星光呓语 App',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextField(
            controller: _userController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'UserName',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  color: Colors.grey,
                )),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            obscureText: true,
            controller: _pwdController,
            decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                )),
          ),
          SizedBox(
            height: 120,
          ),
          Container(
            width: double.infinity,
            color: Colors.lightBlue,
            child: FlatButton(
              child: Text('登录'),
              onPressed: () {
                if (_userController.text.isEmpty||_pwdController.text.isEmpty) {
                  AppToast.show('请输入用户名或密码');
                } else {
                JMessage.login(username:_userController.text,password: _pwdController.text).then((result){
                  if (result!=null) {
                    SpUtil.putString('jUserName', _userController.text);
                    SpUtil.putString('jPassword', _pwdController.text);
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => RootScene()));
                  } else {
                    AppToast.show('用户名或密码错误');
                  }
                }).catchError((error){
                  AppToast.show('登录失败');
                });

                }

              },
            ),
          )
        ],
      
    ),
      ),
      ),
    );
  }
}