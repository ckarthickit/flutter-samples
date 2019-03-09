import 'package:flutter/material.dart';
import './constants.dart';
import './custom_element.dart';
import './src/set_state_demo_page.dart';
import './src/inherited_widget/inherited_widget_demo.dart';
import './src/inherited_widget/inherited_widget_demo2.dart';
import './src/scoped_model/scoped_model_demo.dart';
import './src/inherited_model/inherited_model_demo.dart';

void main() => runApp(MyApp());

var routes = {
  '/': _HomePage(),
  '/setStateDemo': SetStateDemoPage(),
  '/inheritedWidgetDemo' : InheritedWidgetDemoPage(),
  '/inheritedWidgetDemo2' : InheritedWidgetDemoPage2(),
  '/scopedModelDemo' :ScopedModelDemoPage(),
  '/inheritedModelDemo':InheritedModelDemoPage(),
};

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  StatefulElement createElement() => CustomStatefulElement(this);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n"+ StackTrace.current.toString() : ""}');
    return MaterialApp(
      title: 'Flutter Widget Building',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        canvasColor: Colors.purple,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(body1: TextStyle(color: Colors.white)),
      ),
      initialRoute: '/',
      routes: routes
          .map((key, value) => MapEntry(key, (BuildContext context) => value)),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  StatefulElement createElement() => CustomStatefulElement(this);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n"+ StackTrace.current.toString() : ""}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget Building'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          String key = routes.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white54,
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(key),
                ),
                onTap: () {
                  if (key == '/') {return;}
                  Navigator.of(context).pushNamed(key);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
