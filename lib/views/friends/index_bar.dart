import 'package:flutter/material.dart';

int getIndex(BuildContext context,Offset globalPosition){
  //RenderBox对象渲染。触摸位置在容器0点位置也为0
  RenderBox box = context.findRenderObject();
  double y = box.globalToLocal(globalPosition).dy;
  var itemHeight = MediaQuery.of(context).size.height/2/INDEX_WORDS.length;
  int index = y ~/ itemHeight;//取整
  if(index>=0&&index<INDEX_WORDS.length){
    return index;
  }
}

const INDEX_WORDS = [
  '🔍', 'A','B','C','D','E','F','G','H','I','J','K','L',
  'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','#'];



class IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;
  const IndexBar({Key key, this.indexBarCallBack}) : super(key: key);
  @override
  _IndexBarState createState() => _IndexBarState();
}
class _IndexBarState extends State<IndexBar> {

  int _selectorIndex = 0;

  Color _backColor = Color.fromRGBO(1, 1, 1, 0.0);
  Color _textColor = Colors.black;

  double _indicatorY = 0.0;
  String _indicatorText = '';
  bool _indicatorHidden = true;//是否显示

  @override
  Widget build(BuildContext context) {
    //创建索引
    List<Widget>words = [];
    for(int i=0;i<INDEX_WORDS.length;i++){
      words.add(Text(INDEX_WORDS[i],style: TextStyle(fontSize:12,color: _textColor),));
    }
    return Positioned(
      right: 0,
      width: 120,
      height: MediaQuery.of(context).size.height/2,
      top: MediaQuery.of(context).size.height/8,
      child:Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _indicatorY),//-1.1-1.1
            width: 100,
            child: _indicatorHidden?Container():
            Stack(
              alignment: Alignment(-0.2, 0),
              children: <Widget>[
                Image(image: AssetImage("images/气泡.png"),width: 60,),
                Text(_indicatorText,style: TextStyle(fontSize: 35,color: Colors.white),)
              ],
            ),
          ),
          GestureDetector(
            //点击下去
            onVerticalDragDown: (DragDownDetails details){
              print('onVerticalDragDown');
              _backColor = Color.fromRGBO(1, 1, 1, 0.3);
              _textColor = Colors.white;
              setState(() {

              });
              //设置滑动回调
              int index = getIndex(context, details.globalPosition);
              if(index!=_selectorIndex) {
                _selectorIndex = index;
                widget.indexBarCallBack(
                    INDEX_WORDS[getIndex(context, details.globalPosition)]);
              }
              //气泡回调
              _indicatorText = INDEX_WORDS[index];
              _indicatorY = 2.2/(INDEX_WORDS.length-1)*index-1.1;
              _indicatorHidden = false;

              setState(() {

              });
            },
            //监听手势拖拽
            onVerticalDragUpdate: (DragUpdateDetails details){
              print('onVerticalDragUpdate');

              //设置滑动回调
              int index = getIndex(context, details.globalPosition);
              if(index!=_selectorIndex) {
                _selectorIndex = index;
                widget.indexBarCallBack(
                    INDEX_WORDS[getIndex(context, details.globalPosition)]);
              }

              //气泡回调
              _indicatorText = INDEX_WORDS[index];
              _indicatorY = 2.2/(INDEX_WORDS.length-1)*index-1.1;
              _indicatorHidden = false;

              setState(() {});
            },
            //松开
            onVerticalDragEnd: (DragEndDetails details){
              _backColor = Color.fromRGBO(1, 1, 1, 0.0);
              _textColor = Colors.black;

              _indicatorHidden = true;//隐藏
              setState(() {});
            },
            child: Container(
              color: _backColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: words,
              ),

            ),
          )
        ],
      )
    );
  }
}
