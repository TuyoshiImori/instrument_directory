import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instrument_directory/my_instrument_page/my_instrument_page.dart';
import 'package:instrument_directory/other_page.dart';
import 'package:instrument_directory/schedule_page/sepending_page.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:instrument_directory/sns_page.dart';


class BottomTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTab> {
  int _currentIndex = 0;
  final _pageWidgets = [
    ProfilePage(),
    RepairPage(),
    SnsPage(),
    OtherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidgets.elementAt(_currentIndex,),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.trumpet), title: Text('My楽器')),
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.cash_multiple), title: Text('リペア確認')),
          BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.bell), title: Text('SNS')),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), title: Text('その他')),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.deepOrangeAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}


