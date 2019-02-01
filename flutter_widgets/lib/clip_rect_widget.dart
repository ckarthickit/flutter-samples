import 'package:flutter/material.dart';

class ClipRectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = 
      DefaultTextStyle.of(context).style.copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'GabriellWeiss');
    return new Scaffold(
      appBar: AppBar(title: Text("Clip Rect Demo"),),
      body: Material(
        color: Colors.orange,
        child: SafeArea(
          child: Container(
              child: ClipPath(
            clipper: _WelcomePageClipper(),
            child: Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'F',
                          style: defaultTextStyle,
                          children: <TextSpan>[
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.red)),
                            TextSpan(text: "R", style: defaultTextStyle),
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.blue)),
                            TextSpan(text: "I", style: defaultTextStyle),
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.yellow)),
                            TextSpan(text: "E", style: defaultTextStyle),
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.red)),
                            TextSpan(text: "N", style: defaultTextStyle),
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.yellow)),
                            TextSpan(text: "D", style: defaultTextStyle),
                            TextSpan(text: " . ", style: defaultTextStyle.copyWith(color: Colors.blue)),
                            TextSpan(text: "S", style: defaultTextStyle),
                          ]),
                      ),
                    ],
                  ),
                )),
          )),
        ),
      ),
    );
  }
}

class _WelcomePageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var rect = Rect.fromLTWH(
        -50, size.height * 1 / 6, size.width + 100, size.height * 4 / 6);
    var roundRect = RRect.fromRectAndRadius(
        rect, Radius.elliptical(size.width, size.height));
    path.addRRect(roundRect);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
