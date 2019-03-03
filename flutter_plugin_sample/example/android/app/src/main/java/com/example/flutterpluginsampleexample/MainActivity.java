package com.example.flutterpluginsampleexample;

import android.os.Bundle;
import com.example.flutterpluginsampleexample.platformview.text.TextViewFactory;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    TextViewFactory.registerPlatformTextView(this, getPackageName());
  }



}