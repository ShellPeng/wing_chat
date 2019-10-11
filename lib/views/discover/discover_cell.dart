import 'package:flutter/material.dart';
import 'discover_child_page.dart';


class DiscoverCell extends StatefulWidget {
  @required
  final String title;
  @required
  final String imageName;
  final String subTitle;
  final String subImageName;

  const DiscoverCell({
    Key key,
    this.title,
    this.subTitle,
    this.imageName,
    this.subImageName
  }):assert(title != null, 'title不能为空'),
        assert(imageName != null, 'imageName不能为空');
  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DiscoverChildPage(
              title: widget.title,
            )));
      },
      onTapCancel: (){
        print("取消了点击");
      },
      child:Container(
        color: Colors.white,
        height: 54,
        width: 400,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage(widget.imageName),
                    width: 26,
                  ),
                  SizedBox(width: 15,),
                  Text(widget.title,style: TextStyle(fontSize: 16.0),)
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.subTitle!=null?widget.subTitle:'',
                    style: TextStyle(color: Colors.grey,fontSize: 16.0),
                  ),
                  SizedBox(width: 10,),
                  //红点
                  widget.subImageName != null ? Container(
                    child: Image(image: AssetImage(widget.subImageName)),
                    width: 15,
                    margin: EdgeInsets.only(right: 10),
                  ) :Container(),
                  Image(image:AssetImage("images/icon_right.png"),width: 15)
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}