// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class WMTabBar extends StatefulWidget {
  const WMTabBar({Key? key}) : super(key: key);

  @override
  State<WMTabBar> createState() => _WMTabBarState();
}

class _WMTabBarState extends State<WMTabBar> {

  late List<MyNavTabbarItem> itemList;
  String test = "游玩";

  @override
  void initState() {
    super.initState();
    itemList = [];
    itemList.add(MyNavTabbarItem(imagePath: "assets/images/game.png", title: "游玩",isTap: true));
    itemList.add(MyNavTabbarItem(imagePath: "assets/images/explore.png", title: "探索"));
    itemList.add(MyNavTabbarItem(imagePath: "assets/images/shopping.png", title: "商城"));
    itemList.add(MyNavTabbarItem(imagePath: "assets/images/stock.png", title: "库存"));
    itemList.add(MyNavTabbarItem(imagePath: "assets/images/search.png", title: "搜索"));

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          padding: EdgeInsets.only(bottom: 15),
          child: ClipPath(
            clipper: FirstCustomClipper(h: 100),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(0, 0, 0, 0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  myBaseLine(baselineH: 55.0, imageStr: itemList[0].imagePath,tapNum: 0),
                  myBaseLine(baselineH: 35.0, imageStr: itemList[1].imagePath,tapNum: 1),
                  myBaseLine(baselineH: 25.0, imageStr: itemList[2].imagePath,tapNum: 2),
                  myBaseLine(baselineH: 35.0, imageStr: itemList[3].imagePath,tapNum: 3),
                  myBaseLine(baselineH: 55.0, imageStr: itemList[4].imagePath,tapNum: 4),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -25,
          child: ClipPath(
            clipper: SecondCustomClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.black,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 15),
              child: Text(test,style: TextStyle(color: Colors.white),),
            ),
          ),
        )
      ],
    );
  }

  //基线对齐
  Widget myBaseLine({required double baselineH,required String imageStr, double? imageH = 30, required int tapNum}){
    return Baseline(
      baseline: baselineH,
      baselineType: TextBaseline.alphabetic,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: itemList[tapNum].isTap ? Colors.lightBlue : Colors.transparent,blurRadius: 25,spreadRadius: 5)
              ]
          ),
          child: Image.asset(imageStr,width: imageH,height: imageH,),
        ),
        onTap: (){
          if(mounted){
            itemList.forEach((model) {
              model.isTap = false;
            });
            itemList[tapNum].isTap = true;
            test = itemList[tapNum].title;
            setState(() {});
          }
        },
      ),
    );
  }
}

class FirstCustomClipper extends CustomClipper<Path> {
  double h;
  FirstCustomClipper({required this.h});
  @override
  Path getClip(Size size) {
    var path = Path();
    //下曲线
    //p0
    path.lineTo(0,h);
    //p1
    var controllPoint = Offset(size.width / 2, h * 0.6);
    //p2
    var endPoint = Offset(size.width,h);
    //绘制曲线
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);

    //绘制到右下角
    path.lineTo(size.width, h);
    //向上移动到height-50处
    path.lineTo(size.width, h * 0.4);
    var secondControlPoint = Offset(size.width / 2, 0);
    var secondEndPoint = Offset(0, h * 0.4);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(0, h * 0.4);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}

class SecondCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    var controlPoint = Offset(size.width / 2, 0);
    var endPoint = Offset(size.width, size.height * 0.4);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}

class MyNavTabbarItem {
  String imagePath;
  String title;
  bool isTap;
  Color shadowColor;
  MyNavTabbarItem({required this.imagePath, required this.title, this.isTap = false, this.shadowColor = Colors.transparent});
}