import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    //without home we will get an assertion error for "navigatorObservers != null"
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
    );
  }
}