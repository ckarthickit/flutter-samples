import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'platform_text_view.dart';

class PlatformViewDemo extends StatefulWidget {

  const PlatformViewDemo();
  
  @override
  _PlatformViewDemoState createState() => _PlatformViewDemoState();
}

class _PlatformViewDemoState extends State<PlatformViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlatforView Demo : TextView'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: PlatformTextView(
                text: 'TextView from $defaultTargetPlatform',
                onPlatformTextViewCreated: (controller){
                  Future.delayed(Duration(seconds: 5),(){
                    controller.setText("TextView from $defaultTargetPlatform modified ;)");
                  });                  
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}