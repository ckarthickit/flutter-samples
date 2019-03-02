import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginSample {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_sample');
  static const MethodChannel _customChannel = 
      const MethodChannel('flutter_plugin_sample_custom_channel');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get helloWorld async {
    final String message = await _customChannel.invokeMethod('helloWorld');
    return message;
  }
}
