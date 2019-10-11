import 'package:flutter/material.dart';
import 'package:wing_chat/views/discover/discover_child_page.dart';
import 'friends_data.dart';
import 'friends_page_cell.dart';
import 'index_bar.dart';

final ThemeColor = Color.fromRGBO(237, 237, 237, 1.0);

class FriendsScene extends StatefulWidget {
  @override
  _FriendsSceneState createState() => _FriendsSceneState();
}

class _FriendsSceneState extends State<FriendsScene> {
  ScrollController _scrollController;
  final List<Friends> _listData = [];
  double _contextHeight = 0;//content高度
  GlobalKey _contextKey = new GlobalKey();
  //定义位置
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]:0.0,
    INDEX_WORDS[1]:0.0
  };

  //不需要初始
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listData..addAll(datas)..addAll(datas);
    //排序
    _listData.sort((Friends a,Friends b){
      return a.indexLetter.compareTo(b.indexLetter);
    });
    //创建一个scroll
    _scrollController = ScrollController();

    //设置位置
    var _groupOffset = 54.0*4;
    for(int i=0;i<_listData.length;i++){
      if(i<1){
        _groupOffsetMap.addAll({_listData[i].indexLetter:_groupOffset});
        _groupOffset += 84.0;
      }else if(_listData[i].indexLetter==_listData[i-1].indexLetter){//没有头
        _groupOffset += 54.0;
      }else{
        _groupOffsetMap.addAll({_listData[i].indexLetter:_groupOffset});
        _groupOffset += 84.0;
      }
    }
    _contextHeight = _groupOffset;
    _groupOffsetMap.addAll({'🔍':0.0});
  }

  final List<Friends> _headerData = [
    Friends(imageAsset:'images/新的朋友.png', name: '新的朋友',),
    Friends(imageAsset:'images/群聊.png', name: '群聊',),
    Friends(imageAsset:'images/标签.png', name: '标签',),
    Friends(imageAsset:'images/公众号.png', name: '公众号',),
  ];

  //cell
  Widget _itemForRow(BuildContext context,int index){
    if(index<_headerData.length) {
      return FriendCell(
        name:_headerData[index].name,
        imageAsset:_headerData[index].imageAsset,
      );
    }else{
      //分组显示，如果当前标题和上级标题一样就不显示
      if(index>4&&_listData[index-4].indexLetter==_listData[index-5].indexLetter){
        return FriendCell(
          name:_listData[index-_headerData.length].name,
          imageUrl:_listData[index-_headerData.length].imageUrl,
        );
      }
      return FriendCell(
        name:_listData[index-_headerData.length].name,
        imageUrl:_listData[index-_headerData.length].imageUrl,
        indexLetter: _listData[index-_headerData.length].indexLetter,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor,
        title: Text("通讯录",),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext content)=>DiscoverChildPage(title: "添加朋友",))
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image(image: AssetImage('images/icon_friends_add.png'),width: 26,),
            ),
          )
        ],
      ),
      body: Stack(
        key: _contextKey,
        alignment: Alignment.centerRight,
        children: <Widget>[
          Container(
              color: ThemeColor,
              child: ListView.builder(
                controller: _scrollController,
                itemCount:_headerData.length+_listData.length,
                itemBuilder: _itemForRow,
              )
          ),//通讯录列表
          //悬浮控件
          IndexBar(
            indexBarCallBack: (str){
              if(_groupOffsetMap[str]!=null){
                print(_contextHeight);
                // print(ScreenHeight(context));
                print(_scrollController.position.maxScrollExtent);
                print(_contextKey.currentContext.size.height);
                if(_contextHeight-_groupOffsetMap[str]<=_contextKey.currentContext.size.height){
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                }else{
                  _scrollController.animateTo(
                      _groupOffsetMap[str],
                      duration: Duration(milliseconds: 10),
                      curve: Curves.easeIn
                  );
                }
              }
            },
          )
        ],
      )
    );
  }
}
