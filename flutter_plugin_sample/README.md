# flutter_plugin_sample

A new flutter plugin project.

## Getting Started

- This project is a starting point for a Flutter
  [plug-in package](https://flutter.io/developing-packages/),
  a specialized package that includes platform-specific implementation code for
  Android and/or iOS.

- For help getting started with Flutter, view our
  [online documentation](https://flutter.io/docs), which offers tutorials,
  samples, guidance on mobile development, and a full API reference.

- Flutter Plugin creation - CommandLine:  

`flutter create --template=plugin flutter_plugin_sample`

```bash
Creating project flutter_plugin_sample...
  flutter_plugin_sample/LICENSE (created)
  flutter_plugin_sample/ios/flutter_plugin_sample.podspec (created)
  flutter_plugin_sample/ios/.gitignore (created)
  flutter_plugin_sample/ios/Assets/.gitkeep (created)
  flutter_plugin_sample/flutter_plugin_sample.iml (created)
  flutter_plugin_sample/.gitignore (created)
  flutter_plugin_sample/.metadata (created)
  flutter_plugin_sample/ios/Classes/FlutterPluginSamplePlugin.m (created)
  flutter_plugin_sample/ios/Classes/FlutterPluginSamplePlugin.h (created)
  flutter_plugin_sample/android/settings.gradle (created)
  flutter_plugin_sample/android/.gitignore (created)
  flutter_plugin_sample/android/gradle.properties (created)
  flutter_plugin_sample/android/src/main/AndroidManifest.xml (created)
  flutter_plugin_sample/pubspec.yaml (created)
  flutter_plugin_sample/README.md (created)
  flutter_plugin_sample/lib/flutter_plugin_sample.dart (created)
  flutter_plugin_sample/android/build.gradle (created)
  flutter_plugin_sample/android/flutter_plugin_sample_android.iml (created)
  flutter_plugin_sample/android/src/main/java/com/example/flutterpluginsample/FlutterPluginSamplePlugin.java (created)
  flutter_plugin_sample/.idea/runConfigurations/example_lib_main_dart.xml (created)
  flutter_plugin_sample/.idea/libraries/Flutter_for_Android.xml (created)
  flutter_plugin_sample/.idea/libraries/Dart_SDK.xml (created)
  flutter_plugin_sample/.idea/modules.xml (created)
  flutter_plugin_sample/.idea/workspace.xml (created)
  flutter_plugin_sample/CHANGELOG.md (created)
Running "flutter packages get" in flutter_plugin_sample...   3.5s
  flutter_plugin_sample/example/ios/Runner.xcworkspace/contents.xcworkspacedata (created)
  flutter_plugin_sample/example/ios/Runner/Info.plist (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png (created)
  flutter_plugin_sample/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png (created)
  flutter_plugin_sample/example/ios/Runner/Base.lproj/LaunchScreen.storyboard (created)
  flutter_plugin_sample/example/ios/Runner/Base.lproj/Main.storyboard (created)
  flutter_plugin_sample/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata (created)
  flutter_plugin_sample/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme (created)
  flutter_plugin_sample/example/ios/Flutter/Debug.xcconfig (created)
  flutter_plugin_sample/example/ios/Flutter/Release.xcconfig (created)
  flutter_plugin_sample/example/ios/Flutter/AppFrameworkInfo.plist (created)
  flutter_plugin_sample/example/test/widget_test.dart (created)
  flutter_plugin_sample/example/flutter_plugin_sample_example.iml (created)
  flutter_plugin_sample/example/.gitignore (created)
  flutter_plugin_sample/example/.metadata (created)
  flutter_plugin_sample/example/ios/Runner/AppDelegate.h (created)
  flutter_plugin_sample/example/ios/Runner/main.m (created)
  flutter_plugin_sample/example/ios/Runner/AppDelegate.m (created)
  flutter_plugin_sample/example/ios/Runner.xcodeproj/project.pbxproj (created)
  flutter_plugin_sample/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png (created)
  flutter_plugin_sample/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png (created)
  flutter_plugin_sample/example/android/app/src/main/res/drawable/launch_background.xml (created)
  flutter_plugin_sample/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png (created)
  flutter_plugin_sample/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png (created)
  flutter_plugin_sample/example/android/app/src/main/res/values/styles.xml (created)
  flutter_plugin_sample/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png (created)
  flutter_plugin_sample/example/android/app/src/main/AndroidManifest.xml (created)
  flutter_plugin_sample/example/android/gradle/wrapper/gradle-wrapper.properties (created)
  flutter_plugin_sample/example/android/gradle.properties (created)
  flutter_plugin_sample/example/android/settings.gradle (created)
  flutter_plugin_sample/example/pubspec.yaml (created)
  flutter_plugin_sample/example/README.md (created)
  flutter_plugin_sample/example/lib/main.dart (created)
  flutter_plugin_sample/example/android/app/build.gradle (created)
  flutter_plugin_sample/example/android/app/src/main/java/com/example/flutterpluginsampleexample/MainActivity.java (created)
  flutter_plugin_sample/example/android/build.gradle (created)
  flutter_plugin_sample/example/android/flutter_plugin_sample_example_android.iml (created)
  flutter_plugin_sample/example/.idea/runConfigurations/main_dart.xml (created)
  flutter_plugin_sample/example/.idea/libraries/Flutter_for_Android.xml (created)
  flutter_plugin_sample/example/.idea/libraries/Dart_SDK.xml (created)
  flutter_plugin_sample/example/.idea/libraries/KotlinJavaRuntime.xml (created)
  flutter_plugin_sample/example/.idea/modules.xml (created)
  flutter_plugin_sample/example/.idea/workspace.xml (created)
Running "flutter packages get" in example...                10.8s
Wrote 89 files.
```
