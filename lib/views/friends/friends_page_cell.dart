import 'package:flutter/material.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class FriendCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String indexLetter;
  final String imageAsset;
  final String message;
  final String time;
  FriendCell({
    this.imageUrl,
    this.name,
    this.indexLetter,
    this.imageAsset,
    this.message,
    this.time
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            this.indexLetter!=null? Container(
              height: 30.0,
              padding: EdgeInsets.only(left: 10,top:5,bottom: 5),
              width: MediaQuery.of(context).size.width,
              color: ThemeColor,
              child: Text(indexLetter),
            ):Container(height: 0.0,),
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Container(
                          height: 34,
                          width: 34,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              image: DecorationImage(
                                  image:imageUrl!=null?NetworkImage(imageUrl):AssetImage(imageAsset)
                              )
                          ),
                        ),
                      ),
                      Container(
                        height: 53.5,
                        width:MediaQuery.of(context).size.width-55,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(this.name,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
