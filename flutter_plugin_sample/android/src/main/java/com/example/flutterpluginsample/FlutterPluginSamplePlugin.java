package com.example.flutterpluginsample;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginSamplePlugin */
public class FlutterPluginSamplePlugin implements MethodCallHandler {

  private final MethodChannel mCustomChannel;
  private FlutterPluginSamplePlugin(final Registrar registrar) {
    mCustomChannel = new MethodChannel(registrar.messenger(), "flutter_plugin_sample_custom_channel");
    mCustomChannel.setMethodCallHandler(this);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin_sample");
    channel.setMethodCallHandler(new FlutterPluginSamplePlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("helloWorld")) {
      result.success("Hello World From Android");
    } else {
      result.notImplemented();
    }
  }
}
