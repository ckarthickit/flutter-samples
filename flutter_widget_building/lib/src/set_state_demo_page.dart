import 'package:flutter/material.dart';
import '../constants.dart';
import '../custom_element.dart';

class SetStateDemoPage extends StatefulWidget {

  @override
  StatefulElement createElement() => CustomStatefulElement(this);

  @override
  _SetStateDemoPageState createState() => _SetStateDemoPageState();
}

class _SetStateDemoPageState extends State<SetStateDemoPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Binding Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Clicked $_counter times'),
              ),
            ),
            FlatButton(
              color: Colors.teal,
              child: Text('Tap'),
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
            ),
            FlatButton(
              color: Colors.teal,
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  _counter = 0;
                });
              },
            ),
            _AnotherComposedWidget(),
          ],
        ),
      ),
    );
  }
}

class _AnotherComposedWidget extends StatelessWidget {
  final Color color;
  const _AnotherComposedWidget({this.color = Colors.lime});

  @override
  StatelessElement createElement() => CustomStatelessElement(this);


  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n"+ StackTrace.current.toString() : ""}');
    return Container(
      color: Colors.indigo,
      width: MediaQuery.of(context).size.width * .7,
      height: 100.0,
    );
  }
}