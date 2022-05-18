import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'schedule.dart';
import 'Mypage.dart';
import 'chart.dart';
import 'goal/py1.dart';

class NavigationPage extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationPage> {
  var _currentIndex = 0;

  final List<Widget> _children = [
    nameinput(),
    schedulePage(),
    ChartPage(),
    MyPage(),
  ];
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _children[_currentIndex],
        appBar: AppBar(
          title: Text('Motive'),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text("interest"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.add_chart),
              title: Text("Statistics"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
