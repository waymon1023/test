import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabBarPage extends StatefulWidget {
  const MyTabBarPage({Key? key}) : super(key: key);

  @override
  State<MyTabBarPage> createState() => _MyTabBarPageState();
}

class _MyTabBarPageState extends State<MyTabBarPage> {

  final List _titleList = ["游玩","探索","商城","库存","搜索"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("🤔"),
      ),
      body: Container(color: Colors.cyanAccent,),
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  Widget _bottomAppBar(){
    return Container(
      color: Colors.transparent,
      height: 105,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: ClipPath(
          clipper: MyTabbarClip(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: const Color.fromRGBO(0, 0, 0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                myBaseLine(baselineH: 55.0, imageStr: "assets/images/game.png"),
                myBaseLine(baselineH: 35.0, imageStr: "assets/images/explore.png"),
                myBaseLine(baselineH: 25.0, imageStr: "assets/images/shopping.png"),
                myBaseLine(baselineH: 35.0, imageStr: "assets/images/stock.png"),
                myBaseLine(baselineH: 55.0, imageStr: "assets/images/search.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //基线对齐
  Widget myBaseLine({required double baselineH,required String imageStr, double? imageH = 30}){
    return Baseline(
      baseline: baselineH,
      baselineType: TextBaseline.alphabetic,
      child: Image.asset(imageStr,width: imageH,height: imageH,),
    );
  }
}


class MyTabbarClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //下曲线
    //p0
    path.lineTo(0,size.height);
    //p1
    var controllPoint = Offset(size.width / 2, size.height - 30);
    //p2
    var endPoint = Offset(size.width,size.height);
    //绘制曲线
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);

    //绘制到右下角
    path.lineTo(size.width, size.height);
    //向上移动到height-50处
    path.lineTo(size.width, size.height - 50);
    var secondControlPoint = Offset(size.width / 2, 0);
    var secondEndPoint = Offset(0, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(0, size.height - 50);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}