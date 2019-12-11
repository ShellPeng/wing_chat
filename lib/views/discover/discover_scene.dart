import 'package:flutter/material.dart';

import 'discover_cell.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);


class DiscoverScene extends StatelessWidget {
  final Color _themColor = ThemeColor;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     brightness: Brightness.light,
    //     backgroundColor: _themColor,
    //     title: Text("发现",style: TextStyle(color: Colors.black),),
    //     centerTitle: true,
    //   ),
    //   body: Container(
    //     color: _themColor,
    //     height: 800,
    //     child: ListView(
    //       children: <Widget>[
    //         DiscoverCell(
    //           imageName: 'images/朋友圈.png',
    //           title: '朋友圈',
    //           subTitle: '新消息',
    //         ),
    //         Row(
    //           children: <Widget>[Container(height: 10)],
    //         ),
    //         DiscoverCell(
    //           imageName: 'images/扫一扫.png',
    //           title: '扫一扫',
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Container(width: 50,height: 0.5,color: Colors.white,),
    //             Container(height: 0.5,color: ThemeColor,)
    //           ],
    //         ),
    //         DiscoverCell(
    //           imageName: 'images/摇一摇.png',
    //           title: '摇一摇',
    //         ),
    //         Container(height: 10,),
    //         DiscoverCell(
    //           imageName: 'images/看一看icon.png',
    //           title: '看一看',
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Container(width: 50,height: 0.5,color: Colors.white,),
    //             Container(height: 0.5,color: ThemeColor,)
    //           ],
    //         ),
    //         DiscoverCell(
    //           imageName: 'images/搜一搜 2.png',
    //           title: '搜一搜',
    //         ),
    //         SizedBox(height: 10,),
    //         DiscoverCell(
    //           imageName: 'images/附近的人icon.png',
    //           title: '附近的人',
    //         ),
    //         SizedBox(height: 10,),
    //         DiscoverCell(
    //           imageName: 'images/购物.png',
    //           title: '购物',
    //           subTitle: '618限时特价',
    //           subImageName: "images/badge.png",
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Container(width: 50,height: 0.5,color: Colors.white,),
    //             Container(height: 0.5,color: ThemeColor,)
    //           ],
    //         ),
    //         DiscoverCell(
    //           imageName: 'images/游戏.png',
    //           title: '游戏',
    //         ),
    //         SizedBox(height: 10,),
    //         DiscoverCell(
    //           imageName: 'images/小程序.png',
    //           title: '小程序',
    //         ),
    //       ],
    //     ),
    //   )
    // );


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigreation',
            onPressed: () => debugPrint('Navigreation button is pressed'),
          ),
          title: Text('导航'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => debugPrint('Search button is pressed'),
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              tooltip: 'More',
              onPressed: () => debugPrint('More button is pressed'),
            )
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.yellow,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            indicator:UnderlineTabIndicator(borderSide: BorderSide(width: 2,color: Colors.yellow),),
            // indicatorPadding: EdgeInsets.symmetric(horizontal: 50),
            isScrollable: true,
            tabs: <Widget>[
              Container(child: Text('消息',style: TextStyle(fontSize: 20),),width: 50),
              Container(child: Text('告警',style: TextStyle(fontSize: 20)),padding: EdgeInsets.only(left: 10,right: 250),width: 350.0),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.local_florist, size: 128.0, color: Colors.black12),
            Icon(Icons.change_history, size: 128.0, color: Colors.black12),
            // Icon(Icons.change_history, size: 128.0, color: Colors.black12),
            // Icon(Icons.directions_bike, size: 128.0, color: Colors.black12),
          ],
        ),
      ),
    );
  }
}
