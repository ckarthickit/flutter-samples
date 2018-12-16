import 'package:flutter/material.dart';
import 'package:flutter_widgets/text_widget.dart';

var widgetList = ['Text'];

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
          widgetList[0] : (BuildContext context) => TextWidget(),
        },
      );
    }
  }

  class WidgetHome extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      print('Building $widgetList');
      return new Scaffold(
        appBar: AppBar(
          title: Text("Widgets Playground"),
        ),
        body: new ListView.builder(
          itemCount: widgetList.length,
          itemBuilder: (build, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('${widgetList[index]}');
                },
                child: Card(
                  elevation: 5.0,
                  child: new Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Text(widgetList[index], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
