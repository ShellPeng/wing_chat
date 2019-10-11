import 'package:flutter/material.dart';

import 'discover_cell.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);


class DiscoverScene extends StatelessWidget {
  final Color _themColor = ThemeColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: _themColor,
        title: Text("发现",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        color: _themColor,
        height: 800,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              imageName: 'images/朋友圈.png',
              title: '朋友圈',
              subTitle: '新消息',
            ),
            Row(
              children: <Widget>[Container(height: 10)],
            ),
            DiscoverCell(
              imageName: 'images/扫一扫.png',
              title: '扫一扫',
            ),
            Row(
              children: <Widget>[
                Container(width: 50,height: 0.5,color: Colors.white,),
                Container(height: 0.5,color: ThemeColor,)
              ],
            ),
            DiscoverCell(
              imageName: 'images/摇一摇.png',
              title: '摇一摇',
            ),
            Container(height: 10,),
            DiscoverCell(
              imageName: 'images/看一看icon.png',
              title: '看一看',
            ),
            Row(
              children: <Widget>[
                Container(width: 50,height: 0.5,color: Colors.white,),
                Container(height: 0.5,color: ThemeColor,)
              ],
            ),
            DiscoverCell(
              imageName: 'images/搜一搜 2.png',
              title: '搜一搜',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              imageName: 'images/附近的人icon.png',
              title: '附近的人',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              imageName: 'images/购物.png',
              title: '购物',
              subTitle: '618限时特价',
              subImageName: "images/badge.png",
            ),
            Row(
              children: <Widget>[
                Container(width: 50,height: 0.5,color: Colors.white,),
                Container(height: 0.5,color: ThemeColor,)
              ],
            ),
            DiscoverCell(
              imageName: 'images/游戏.png',
              title: '游戏',
            ),
            SizedBox(height: 10,),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '小程序',
            ),
          ],
        ),
      )
    );
  }
}
