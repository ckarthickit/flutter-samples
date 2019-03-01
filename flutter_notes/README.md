# Flutter Learnings

## Flutter Framework Internals

### Flutter Plugins

#### Flutter PluginRegistry

- `Registry used by plugins to set up interaction with Android/iOS APIs`.
- Flutter applications by default include an auto-generated and auto-updated `plugin registrant class (GeneratedPluginRegistrant)` that makes use of `PluginRegistry` to register contributions of each plugin
mentioned in `pubspec.yaml`.
- Default `PluginRegistry` in each platform:

    ```java
    public class FlutterActivity extends Activity implements Provider, PluginRegistry, ViewFactory
    ```

    ```objective-c
    @interface FlutterAppDelegate: UIResponder <UIApplicationDelegate, FlutterPluginRegistry, FlutterAppLifeCycleProvider>
    ```

- Important methods (Equivalent APIs are available in `iOS` as well)

  ```java

   Registrar registrarFor(String pluginUniqueKey);

   boolean hasPlugin(String pluginUniqueKey);

   /**
     * Plugins may publish a single value, such as an instance of the
     * plugin's main class, for situations where external control or
     * interaction is needed. Clients are expected to know the value's
     * type.
   **/
   <T> T valuePublishedByPlugin(String pluginUniqueKey);
  ```

- References:
  - [PluginRegistry in Android](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/plugin/common/PluginRegistry.java)
  - [PluginRegistry in iOS](https://github.com/flutter/engine/blob/99f3f7a9c246f1ebedc6eefd867cde250b370380/shell/platform/darwin/ios/framework/Headers/FlutterPlugin.h#L331)

#### Flutter Plugin Registrar

- Registration context for a single `FlutterPlugin`, providing a `one stop shop for the plugin to access contextual information` and `register callbacks` for various application events. (Receiver of registrations from a single plugin).
- Important methods (Equivalent APIs are available in `iOS` as well)

  ```java
  /**
   * Android only
   * Returns the {@link Activity} that forms the plugin's operating context.
   * When there is no foreground activity in the application, this will return null.
   */
  Activity activity();
  /**
   * Android only
   * Returns the {@link android.app.Application}'s {@link Context}.
   */
  Context context();
  /**
   * Android only
   * @return the current {@link #activity() Activity}, if not null,
   * otherwise the {@link #context() Application}.
   */
  Context activeContext();

  
  /**************** COMMON ******************/
  /**
   * Returns a {@link BinaryMessenger} which the plugin can use
   * for creating channels for Dart/Android and Dart/iOS Communiation.
   */
   BinaryMessenger messenger();

  /**
   * Plugins can use the platform registry to register their view factories.
   */
   PlatformViewRegistry platformViewRegistry();

  /**
    * Returns the file name for the given asset which originates from the specified package.
    */
   String lookupKeyForAsset(String asset, String packageName);
  ```

  - PlatformViewRegistry

    ```java
    /**
     * Registers a factory for a platform view.
     *
     * @param viewTypeId unique identifier for the platform view's type.
     * @param factory    factory for creating platform views of the specified type.
     * @return true if succeeded, false if a factory is already registered for viewTypeId.
     */
    boolean registerViewFactory(String viewTypeId, PlatformViewFactory factory);
    ```

    ```objc
    /**
    * Registers a `FlutterPlatformViewFactory` for creation of platfrom views.
    *
    * Plugins expose `UIView` for embedding in Flutter apps by registering a view factory.
    *
    * @param factory The view factory that will be registered.
    * @param factoryId A unique identifier for the factory, the Dart code of the Flutter app can use
    *   this identifier to request creation of a `UIView` by the registered factory.
    */
    - (void)registerViewFactory:(NSObject<FlutterPlatformViewFactory>*)factory withId:(NSString*)factoryId;
    ```

#### FlutterPlugin (in iOS) / MethodCallHandler (in Android)

- A handler of incoming method calls.
- Methods (Equivalent is available in iOS):

  ```java
  /**
   * * CLASS METHOD * 
   * Registers a plugin using the context information and callback registration
   * methods exposed by the given registrar.
   */
  public static void registerWith(Registrar registrar);
  /**
   * Handles the specified method call received from Flutter.
   */
  public void onMethodCall(MethodCall call, Result result);
  ```

#### Method Channel

##### Flutter Engine - Method Channel

- A channel for communicating with the Flutter side using invocation of asynchronous methods.
- Methods (Equivalent is available in iOS):

  ```java
    /**
    * Invokes a method on this channel, expecting no result.
    */
    public void invokeMethod(@NonNull String method, @Nullable Object arguments);
    /**
    * Invokes a method on this channel, optionally expecting a result.
    */
    public void invokeMethod(String method, @Nullable Object arguments, Result callback);
  ```

##### Flutter Framework - Method Channel

- A named channel for communicating with platform plugins using asynchronous method calls.
- Method calls are encoded into binary before being sent.
- And binary results received are decoded into Dart values.
- The `MethodCodec` used must be compatible with the one used by the platform plugin.
- Methods (in Dart)

  ```dart
   ///Invokes a method on this channel from Dart Side to Platform Side
   Future<T> invokeMethod<T>(String method, [dynamic arguments]) async();

   ///Sets a callback for receiving method calls on this channel from Platform side.
   void setMethodCallHandler(Future<dynamic> handler(MethodCall call));
  ```

- References
  - [MethodChannel in Dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/services/platform_channel.dart)
  - [MethodChannel in Android](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/plugin/common/MethodChannel.java)
  - [FlutterMethodChannel in iOS](https://github.com/flutter/engine/blob/66042161eba17da968800c57ddd2c314cd787abb/shell/platform/darwin/ios/framework/Headers/FlutterChannels.h#L157)

#### Misc

- References:
  - [Registrar in Android](https://github.com/flutter/engine/blob/99f3f7a9c246f1ebedc6eefd867cde250b370380/shell/platform/android/io/flutter/plugin/common/PluginRegistry.java#L63)
  - [FlutterPluginRegistrar in iOS](https://github.com/flutter/engine/blob/99f3f7a9c246f1ebedc6eefd867cde250b370380/shell/platform/darwin/ios/framework/Headers/FlutterPlugin.h#L231)