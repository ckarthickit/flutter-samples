import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';


typedef PlatFormTextViewCreatedCallback = void Function(PlatformTextViewController controller);

const _viewType = 'in.flutter.karthick/textview';
class PlatformTextView extends StatefulWidget {
  final String text;
  final PlatFormTextViewCreatedCallback onPlatformTextViewCreated;

  const PlatformTextView({
    Key key,
    this.text,
    this.onPlatformTextViewCreated,
  }):super(key:key);
  @override
  _PlatformTextViewState createState() => _PlatformTextViewState();
}

class _PlatformTextViewState extends State<PlatformTextView> {
  PlatformTextViewController _controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }else if(defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the platform_text_view plugin');
  }

  void _onPlatformViewCreated(int id) {
     _controller = new PlatformTextViewController._(id);
     //configure PlatformTextView
     _controller.setText(widget.text);

    //Invoke Callback 
    if(widget.onPlatformTextViewCreated == null) {
      return;
    }
    widget.onPlatformTextViewCreated(_controller);
  }

}

class PlatformTextViewController {
  final MethodChannel _channel;
  PlatformTextViewController._(final int id)
      :_channel = new MethodChannel('${_viewType}_$id');

  Future<void> setText(final String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }

}