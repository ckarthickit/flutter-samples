import 'package:flutter/material.dart';

void main() => runApp(WidgetApp());

  class WidgetApp extends StatelessWidget {
    Widget build(BuildContext context) {
      return MaterialApp(
        title: "Flutter Widgets Demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange
        ),
        home: WidgetHome(),
        routes: <String,WidgetBuilder>{
        },
      );
    }
  }

  class WidgetHome extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      var widgetList = [];
      print(widgetList);
      return new Scaffold(
        appBar: AppBar(
          title: Text("Widgets Playground"),
        ),
        body: new Container(),
      );
    }
  }
