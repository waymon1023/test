import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: MyClipper(),
        child: Container(
          height: 320,
          color: Colors.redAccent,
          child: const Center(
            child: Text(
              "waymon",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 45,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    
    
    ///p1
    var controllPoint = Offset(size.width/2, size.height);
    ///p2
    var endPoint = Offset(size.width, size.height - 50);
    ///绘制贝塞尔曲线
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}