import 'package:flutter/material.dart';

import 'package:flutter_plugin_sample_example/pages.dart';

void main() => runApp(MyApp());

typedef Widget WidgetsBuilder(BuildContext context);

const pageNames = <String>['Method Channels - Using Plugin', 'PlatformView Demo - TextView'];
const pageWidgets = <Widget>[
  const MethodChannelDemo(),
  const PlatformViewDemo(),
];

// var pageWidgetsBuilder = <WidgetsBuilder>[
//   (BuildContext context) => CustomChannel(),
// ];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Plugins Example'),
        ),
        body: ListView.builder(
          itemCount: pageNames.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: InkWell(
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(pageNames[index], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          Icon(Icons.keyboard_arrow_right, color: Colors.blueAccent,),
                        ],
                      )
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(pageNames[index]);
                  },
              ),
            );
          },
        ),
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return PageRouteBuilder(
          pageBuilder: (BuildContext context,
            Animation<double> animation, Animation<double> secondaryAnimation) {
            return pageWidgets[pageNames.indexOf(routeSettings.name)];
          }, 
          transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        });
      },
    );
  }
}
