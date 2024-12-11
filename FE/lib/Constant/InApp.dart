import 'package:dart_findy/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './BaseUI.dart';

import '../Screen/01_Search/Search.dart';
import '../Screen/02_Wish/Wish.dart';
import '../Screen/03_Home/Home.dart';
import '../Screen/04_ChatBot/ChatBot.dart';
import '../Screen/05_Profile/Profile.dart';


class InApp extends StatefulWidget {
  const InApp({super.key});

  @override
  State<InApp> createState() => _InAppState();
}

class _InAppState extends State<InApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _index = 2;
  var _name = 'Home';

  final List<String> _navName = ['Search', 'Wish', 'Home', 'ChatBot', 'Profile'];
  final List<Widget> _navIdex = [
    SearchPage(),
    WishPage(),
    HomePage(),
    ChatBotPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _navItems.length, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _index = _tabController.index;
      _name = _navName.elementAt(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppBarStyle.backgroundColor,
        title: Text(_name, style: AppBarStyle.titleTextStyle),
        elevation: AppBarStyle.elevation,
      ),
      body: _navIdex.elementAt(_index),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          child: BottomNavigationBar(
            backgroundColor: BottomNavStyle.backgroundColor,
            selectedItemColor: BottomNavStyle.selectedItemColor,
            unselectedItemColor: BottomNavStyle.unselectedItemColor,
            type: BottomNavStyle.type,
            elevation: BottomNavStyle.elevation,
            onTap: (int index) {_tabController.animateTo(index);},
            currentIndex: _index,
            items: _navItems.map((item) { return BottomNavigationBarItem
              (label: item.label,
              icon: Icon(_index == item.index ? item.activeIcon : item.inactiveIcon, size: item.size),
            );}).toList(),
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        )
    );
  }
}

const _navItems = [
  NavItem(
    index: 0,
    size: 25,
    activeIcon: Icons.search,
    inactiveIcon: Icons.search_outlined,
    label: 'Search',
  ),
  NavItem(
    index: 1,
    size: 25,
    activeIcon: Icons.favorite,
    inactiveIcon: Icons.favorite_border_outlined,
    label: 'Wish',
  ),
  NavItem(
    index: 2,
    size: 29,
    activeIcon: Icons.home,
    inactiveIcon: Icons.home_outlined,
    label: 'Home',
  ),
  NavItem(
    index: 3,
    size: 23,
    activeIcon: Icons.chat,
    inactiveIcon: Icons.chat_outlined,
    label: 'ChatBot',
  ),
  NavItem(
    index: 4,
    size: 25,
    activeIcon: Icons.person,
    inactiveIcon: Icons.person_outlined,
    label: 'Profile',
  ),
];


