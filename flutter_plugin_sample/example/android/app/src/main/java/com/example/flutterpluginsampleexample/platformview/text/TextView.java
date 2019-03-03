package com.example.flutterpluginsampleexample.platformview.text;

import android.app.ActionBar.LayoutParams;
import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.platform.PlatformView;

public class TextView implements PlatformView, MethodCallHandler {
  private static final String TAG = "TextView";
  private android.widget.TextView mTextView;
  private final MethodChannel textViewChannel;
  private final String mUniqueID;
  public TextView(final Context context, final BinaryMessenger messenger, final String uniqueID) {
    mTextView = new android.widget.TextView(context);
    mTextView.setLayoutParams(new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    mUniqueID = uniqueID;
    textViewChannel = new MethodChannel(messenger, mUniqueID);
    textViewChannel.setMethodCallHandler(this);
  }
  @Override
  public View getView() {
    return mTextView;
  }

  @Override
  public void dispose() {
    Log.i(TAG, "disposing text-view with id: " + mUniqueID);
    mTextView = null;
  }

  @Override
  public void onMethodCall(MethodCall methodCall, Result result) {
    switch (methodCall.method) {
      case "setText": {
        String text = (String) methodCall.arguments;
        mTextView.setText(text);
        result.success(null);
      }
      break;
      case "setBackgroundColor": {
        long bgColor = (long)methodCall.arguments;
        mTextView.setBackgroundColor((int)bgColor);
        result.success(null);
      }
      break;
      default:{

      }
      break;
    }
  }
}
