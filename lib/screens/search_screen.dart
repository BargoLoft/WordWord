import 'dart:io';

import 'package:WordWord/screens/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:WordWord/widgets/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

int value = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  int getPage() {
    return value;
  }

  void setPage(int page) {
    value = page;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late SharedPreferences preference;

  //bool _isVisible = false;
  @override
  void initState() {
    _pageController = PageController(
      keepPage: true,
      initialPage: widget.getPage(),
    );
    super.initState();
    init();
  }
  //
  // animateIcon() {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     setState(() {
  //       _isVisible = !_isVisible;
  //     });
  //   });
  // }
  //
  // autoNavigate() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   });
  // }

  Future init() async {
    preference = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    //Hive.close();
    _pageController.dispose();
    //Hive.box('word_box').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: Word(word: ''),
      // PageView(
      //   controller: _pageController,
      //   scrollDirection: Axis.vertical,
      //   physics: const PageScrollPhysics(),
      //   children: [
      //     Word(word: ''),
      //     const StorageScreen(),
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.grey.shade500,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white.withOpacity(.60),
      //   selectedFontSize: 14,
      //   unselectedFontSize: 14,
      //   currentIndex: _selectedIndex, //현재 선택된 Index
      //   onTap: (int index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       label: '다',
      //       icon: Icon(Icons.search),
      //     ),
      //     BottomNavigationBarItem(
      //       label: '너',
      //       icon: Icon(Icons.storage),
      //     ),
      //     BottomNavigationBarItem(
      //       label: '다너',
      //       icon: Icon(Icons.info),
      //     ),
      //   ],
      // ),
    );
  }
}