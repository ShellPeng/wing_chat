// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wing_chat/provider/root_scene_provider.dart';
import 'friends/friends_scene.dart';
import 'message/message_list_scene.dart';
import 'discover/discover_scene.dart';
import 'mine/mine_page.dart';


class RootScene extends StatelessWidget {
  final List<Widget> _tabPages = <Widget>[
    MessageListScene(),
    FriendsScene(),
    DiscoverScene(),
    MineScene()
  ];

  List<BottomNavigationBarItem> _bottomTabs() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
                  icon: Image(image: AssetImage('images/tabbar_chat.png'),height: 24,),
                  activeIcon: Image(image: AssetImage('images/tabbar_chat_hl.png'),height: 24,),
                  title: Text('微信')
              ),
              BottomNavigationBarItem(
                  icon: Image(image: AssetImage('images/tabbar_friends.png'),height: 24,),
                  activeIcon: Image(image: AssetImage('images/tabbar_friends_hl.png'),height: 24,),
                  title: Text('通讯录')
              ),
              BottomNavigationBarItem(
                  icon: Image(image: AssetImage('images/tabbar_discover.png'),height: 24,),
                  activeIcon: Image(image: AssetImage('images/tabbar_discover_hl.png'),height: 24,),
                  title: Text('发现')
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/tabbar_mine.png'),height: 24,),
                activeIcon: Image(image: AssetImage('images/tabbar_mine_hl.png'),height: 24,),
                title: Text('我'),
              ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => RootSceneProvider()),
      ],
      child: Consumer<RootSceneProvider>(builder: (context,provider,widget){
        return Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(index: provider.currentIndex, children: _tabPages),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            fixedColor: Colors.green,
            items: _bottomTabs(),
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIndex,
            onTap: (index) {
              provider.currentIndex = index;
              if (index == 0) {

              } else if (index == 1) {

              }
            },
          ),
        );
      })
    );
  }
}

// class RootScene extends StatelessWidget {
//   final List<Widget> _tabPages = <Widget>[
//     MessageListScene(),
//     FriendsScene(),
//     DiscoverScene(),
//     MineScene()
//   ];

//   List<BottomNavigationBarItem> _bottomTabs(int selectIndex, int unreadCount) {
//     return <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//                   icon: Image(image: AssetImage('images/tabbar_chat.png'),height: 24,),
//                   activeIcon: Image(image: AssetImage('images/tabbar_chat_hl.png'),height: 24,),
//                   title: Text('微信')
//               ),
//               BottomNavigationBarItem(
//                   icon: Image(image: AssetImage('images/tabbar_friends.png'),height: 24,),
//                   activeIcon: Image(image: AssetImage('images/tabbar_friends_hl.png'),height: 24,),
//                   title: Text('通讯录')
//               ),
//               BottomNavigationBarItem(
//                   icon: Image(image: AssetImage('images/tabbar_discover.png'),height: 24,),
//                   activeIcon: Image(image: AssetImage('images/tabbar_discover_hl.png'),height: 24,),
//                   title: Text('发现')
//               ),
//               BottomNavigationBarItem(
//                 icon: Image(image: AssetImage('images/tabbar_mine.png'),height: 24,),
//                 activeIcon: Image(image: AssetImage('images/tabbar_mine_hl.png'),height: 24,),
//                 title: Text('我'),
//               ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(builder: (_) => RootSceneProvider()),
//         // ChangeNotifierProvider(
//         //     builder: (_) => GroupListProvider()..loginStatusCheck()),
//         // ChangeNotifierProvider(builder: (_) => CourseProvider()..getData()),
//       ],
//       child: Consumer<RootSceneProvider>(
//           builder: (context, provider, widget) {
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: IndexedStack(index: provider.currentIndex, children: _tabPages),
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             items:
//                 _bottomTabs(provider.currentIndex, provider.currentIndex),
//             type: BottomNavigationBarType.fixed,
//             currentIndex: provider.currentIndex,
//             onTap: (index) {
//               provider.currentIndex = index;
//               if (index == 1) {
//                 // groupProvider.loginStatusCheck();
//               } else if (index == 0) {
//                 // courseProvider.getData();
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
