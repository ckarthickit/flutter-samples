# Flutter Learnings

## Flutter Basic Classes

### RenderObject

- An `object in the render tree`.
- The `RenderObject` class hierarchy is the core of the rendering library's reason for being.
- Class Declaration:

  ```dart
  abstract class RenderObject extends AbstractNode with DiagnosticableTreeMixin implements HitTestTarget{
  }
  ```

- Have a `parent`, and  and have a slot called `parentData` in which
the parent `RenderObject` can store child-specific data.
- Protocols Implemented by `Render Objects`
  - `Layout`
    - Sizing based on a set of constraints provided to them (Renderbox).
    - "Normally" sizing is done purely based on constraints.
      - `sizedByParent` returns true and `performResize` is overrideen in this case.
    - "Otherwise", size is set in the `performLayout` function.
      - This is responsible for calling `layout` on each (box) child.
    - **`markNeedsLayout` is called for re-layout**.
  - `Painting`
    - `paint` method is overridden to describe how RenderBox paints with `PaintingContext`
    and an `Offset`.
    - The `paint` method's `context` argument has a `PaintingContext.paintChild` method,
    which should be called for each child that is to be painted.
    - **`markNeedsPaint` is called for re-painting**.
  - `Hit Tests`
    - Determines the set of render objects located at the given position.
  - `Semantics`
    - Implemented, for a render box to be accessible.
    - `semanticsAnnotator` is used.
  - __`RenderBox` sub-class__ .
    - A render object in a 2D Cartesian coordinate system.
    - Protocols Implemented by `RenderBox`
      - `Intrinsics and Baselines`
        - `computeMinIntrinsicWidth` , `computeMaxIntrinsicWidth`, `computeMinIntrinsicHeight`, `computeMaxIntrinsicHeight`
        methods are used to implement this protocol.

### Widgets

#### StatelessWidget

- Class

  ```dart
  abstract class StatelessWidget extends Widget {
    StatelessElement createElement() => StatelessElement(this);
  }
  ```

#### StatefulWidget

- Class

  ```dart
  abstract class StatefulWidget extends Widget {
     StatefulElement createElement() => StatefulElement(this);
  }
  ```

#### ProxyWidget

- A widget that has a child widget provided to it, instead of building a new Widget
- Has `exactly one child widget`.
- Class

  ```dart
  abstract class ProxyWidget extends Widget {

    /// createElement is abstract and provided by classes extending this Widget.
    Element createElement();

    /// The widget below this widget in the tree.
    final Widget child;
  }
  ```

#### RenderObjectWidget

- RenderObjectWidgets provide the configuration for `RenderObjectElement`s, which wrap `RenderObject`s, which provide the actual rendering of the application.
- Class

  ```dart
  abstract class RenderObjectWidget extends Widget{
  
    /// RenderObjectWidgets always inflate to a [RenderObjectElement] subclass.
    RenderObjectElement createElement();
  }
  ```

#### RenderObjectToWidgetAdapter

- A bridge from a `RenderObject` to an `Element` tree.
- **Properties**
  - `final Widget child;` - The widget below this widget in the tree.

### Elements

- An instantiation of a `Widget` at a particular location in the tree.
- `is a` **BuildContext** by itslef.
- **Lifecycle:**
  - Framework calls `Widget.createElement` to create and `Element`.
  - Framework calls `Element.mount` to  add it to Element Tree.
    - Element is considered `"active"` at this point.
  - Framework calls `update(covariant Widget newWidget)` with new widget.
    - Parent might decide to `change the widget used to configure this element`. (Eg., Parent rebuild with new state)
    - The new widget will always have the same `runtimeType` and `key` as old widget. (`Else the Element is unmount`-ed
    instead of being updated).
  - Framework calls `deactivateChild` on an **Ancestor element** with a **Child Element**.
    - An ancestor might decide to remove this element (or an intermediate ancestor) from the tree.
    - Element is considered `"inactive"` and will not appear
    - At the `end of the animation frame`, any elements that are still inactive will be `unmounted`.
  - Framework calls `activate` on the element, and re-attaches the element's render object to render tree.
    - If Element gets reincorporated into the tree
    - Element is considered `"active"` at this point.
  - Framework calls [unmount] on the Element.
    - If the element does not get reincorporated into the tree by the end of the current animation frame
    - Element is considered `"defunct"` and will not be reincorporated in the future.
  - Class

    ```dart
    abstract class  Element extends DiagnosticableTree implements BuildContext {

      /// The configuration for this element.
      Widget get widget => _widget;

      /// The object that manages the lifecycle of this element.
      BuildOwner get owner => _owner;

    }
    ```

#### ComponentElement

- An **Element** that `composes` other **Elements**.
- Rather than creating a `RenderObject` directly, a `ComponentElement` creates `RenderObject`s indirectly by creating other `Element`s.
- Contrast with `RenderObjectElement`.

##### StatelessElement

- Class Info

  ```dart
  class StatelessElement extends ComponentElement {
    ///Calls build method on the Widget passing itself as context.
    Widget build() => widget.build(this);
  }
  ```

##### StatefulElement

- Class Info

  ```dart
  class StatefulElement extends ComponentElement {
  
    ///State Object
    State<StatefulWidget> get state => _state;
    State<StatefulWidget> _state;

    StatefulElement(StatefulWidget widget)
          :_state = widget.createState(),
          super(widget){

    }

    ///Calls build method on the State Object
    Widget build() => state.build(this);
  }
  ```

##### ProxyElement

- Class Info

  ```dart
  abstract class ProxyElement extends ComponentElement {

    ProxyElement(ProxyWidget widget) : super(widget);

    ProxyWidget get widget => super.widget;
  
    /// Simply returns the Child Widget, without building it ?
    /// Who calls build on the child widget with some BuildContext ?
    Widget build() => widget.child;
  }
  ```

#### RenderObjectElement

- Have an associated `RenderObject` widget in the render tree, which handles concrete operations like
  1. Laying out,
  2. Painting,
  3. Hit Testing,
- spend much of their time acting as `intermediaries` between their `widget` and their `renderObject`.
- Each **child Element** corresponds to a **RenderObject** which should be attached to this `element's render object`     as a child.\
  However, the `immediate children of the element may not be the ones` that eventually produce the actual **RenderObject**. Eg., (StatelessElement and othet `ComponentElement`s).

##### RootRenderObjectElement

- Element at the root of the tree

##### LeafRenderObjectElement

- Handles, Leaf render Objects, with no children

##### SingleChildRenderObjectElement

- Handles, a Single Child

##### MultiChildRenderObjectElement

- Handles, a `Linked-List of Children`.

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