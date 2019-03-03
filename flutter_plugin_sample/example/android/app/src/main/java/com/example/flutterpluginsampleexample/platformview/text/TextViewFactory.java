package com.example.flutterpluginsampleexample.platformview.text;

import android.content.Context;
import android.util.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;

public class TextViewFactory extends io.flutter.plugin.platform.PlatformViewFactory {
  private static final String TAG = "TextViewFactory";
  public static final String VIEW_TYPE = "in.flutter.karthick/textview";

  private final BinaryMessenger messenger;

  public TextViewFactory(final BinaryMessenger messenger) {
    super(StandardMessageCodec.INSTANCE);
    this.messenger = messenger;
  }

  @Override
  public PlatformView create(Context context, int id, Object o) {
    Log.i(TAG, "create Requested for  " + VIEW_TYPE + " with id: " + id);
    return new TextView(context, messenger, VIEW_TYPE + "_" + id);
  }

  /************************ STATIC METHODS *****************/

  public static void registerPlatformTextView(final PluginRegistry registry,
      final String packageName) {
    Log.i(TAG, "registerPlatformTextView :" + packageName);
    if (alreadyRegisteredWith(registry, packageName)) {
      return;
    }

    Registrar registrar = registry.registrarFor(packageName + "platformview.text");
    registrar.platformViewRegistry()
        .registerViewFactory(VIEW_TYPE, new TextViewFactory(registrar.messenger()));
    Log.i(TAG, "registered " + VIEW_TYPE);
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry, final String pluginKey) {
    if (registry.hasPlugin(pluginKey)) {
      return true;
    }
    registry.registrarFor(pluginKey);
    return false;
  }
}
