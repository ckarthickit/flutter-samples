import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_sample/flutter_plugin_sample.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _helloWorldMsg = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String helloWorldMsg;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPluginSample.platformVersion;
      helloWorldMsg = await FlutterPluginSample.helloWorld;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _helloWorldMsg = helloWorldMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Text('Running on: $_platformVersion\n'),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.yellow),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                'Msg : $_helloWorldMsg\n', 
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.deepOrange),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.yellow),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                'Msg : $_platformVersion\n', 
                style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.deepOrange),
                ),
              ),
            ),
          ], 
        ),
      ),
    );
  }
}
