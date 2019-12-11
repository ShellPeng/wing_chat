import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AppToast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg,gravity: ToastGravity.CENTER,backgroundColor: Color.fromRGBO(231, 236, 242, 1),textColor: Colors.black);
  }
}