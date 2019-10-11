import 'package:flutter/material.dart';
import 'package:wing_chat/views/discover/discover_cell.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class MineScene extends StatefulWidget {
  @override
  _MineSceneState createState() => _MineSceneState();
}

class _MineSceneState extends State<MineScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: ThemeColor,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(height: 20,),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height:70,
                              width: 70,
                              decoration: BoxDecoration(
                                color:Colors.blue,
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(image: AssetImage("images/dog.jpg"))
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width-110,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height:35,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "飞鱼",
                                          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
                                        ),
                                      ),//微信名称
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("微信号：PP514718793",
                                              style: TextStyle(fontSize: 17.0,color: Colors.grey)
                                            ),
                                            Image(image:AssetImage("images/icon_right.png"),width: 15)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                DiscoverCell(
                  imageName: 'images/微信 支付.png',
                  title: '支付',
                ),
                Row(
                  children: <Widget>[
                    Container(width: 50,height: 0.5,color: Colors.white,),
                    Container(height: 0.5,color: Colors.grey,),
                  ],
                ),
                DiscoverCell(
                  imageName: 'images/微信收藏.png',
                  title: '收藏',
                ),
                Row(
                  children: <Widget>[
                    Container(width: 50,height: 0.5,color: Colors.white,),
                    Container(height: 0.5,color: Colors.grey,),
                  ],
                ),
                DiscoverCell(
                  imageName: 'images/微信相册.png',
                  title: '相册',
                ),
                Row(
                  children: <Widget>[
                    Container(width: 50,height: 0.5,color: Colors.white,),
                    Container(height: 0.5,color: Colors.grey,),
                  ],
                ),
                DiscoverCell(
                  imageName: 'images/微信卡包.png',
                  title: '卡包',
                ),
                Row(
                  children: <Widget>[
                    Container(width: 50,height: 0.5,color: Colors.white,),
                    Container(height: 0.5,color: Colors.grey,),
                  ],
                ),
                DiscoverCell(
                  imageName: 'images/微信表情.png',
                  title: '表情',
                ),
                Container(height: 10,),
                DiscoverCell(
                  imageName: 'images/微信设置.png',
                  title: '设置',
                ),
              ],
            ),
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 40,right: 15),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(image: AssetImage("images/相机.png"),width: 26,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
