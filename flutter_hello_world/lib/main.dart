import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Hello App",
    //without home we will get an assertion error for "navigatorObservers != null"
    home: MyHomePage(),
    theme: ThemeData(
      primarySwatch: Colors.amber
    ),
  ));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
        Scaffold contains the basic material design visual layout structure
        like AppBar , Floating Action Button , Snackbar, drawer etc.,
     */
    return new Scaffold(
      body: Container(
        color: Colors.white,
      ),
    );
  }
}