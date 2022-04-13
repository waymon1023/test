// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_tabbar/my_tabbar.dart';

class MyTabBarPage extends StatefulWidget {
  const MyTabBarPage({Key? key}) : super(key: key);

  @override
  State<MyTabBarPage> createState() => _MyTabBarPageState();
}

class _MyTabBarPageState extends State<MyTabBarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("🤔"),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          PageView(
            children: [
              Container(color: Colors.red,),
              Container(color: Colors.cyanAccent,),
              Container(color: Colors.black,),
              Container(color: Colors.white,),
              Container(color: Colors.pink,),
            ],
          ),
          WMTabBar(),
        ],
      ),
    );
  }

}


