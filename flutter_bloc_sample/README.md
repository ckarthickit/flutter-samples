# A Flutter project that Demos about `BLoC pattern` and `Built Value`. 
  - `BLoC` - Also known as *B*usiness *Lo*gic *C*omponent is used to seperate Business Logic from UI
    - Accepts `Events` as input , and emits `State` as output 
    - UI Components add `Event`s to `Event-Stream Sink` and recieve `State` from `State-Stream Stream`
    - BLoC Components recieve `Event`s from `Event-Stream Stream` and add/emit `State` to `State-Stream Sink`
  - `Built-Value` - Generates all necessary Boiler plate code for Model/Value classes 
     that come in handly during implementation

## Notes
- Use `https://charafau.github.io/json2builtvalue/` to built-value class from a JSON
- We will be using Hacker New API to demo this
# Generating Built Value for a Class :
  - Type the following "minimal" abstract class declaration in a file before we run build_runner
    ```
    import 'package:built_value/built_value.dart';
    abstract class Value implements Built<Value,ValueBuilder> {
    }
    ```
  -  Use `flutter packages pub run build_runner build` to generate part file for `built-value` class
  - `build_runner` will automatically report needed code changes that we need to do one by one
  - Final "Manually" declared class will be  something like below :
    ```
    import 'package:built_value/built_value.dart';
    
    part 'value.g.dart';
    
    abstract class Value implements Built<Value,ValueBuilder> {
    Value._();
    factory Value([updates(ValueBuilder b)]) = _$Value;
    }
    ```
  - Use `flutter packages pub run build_runner build` to generate part file for `built-value` class
  - Since Built-Values's are immutable , we need only define getters for the properties that it has
  ```
  import 'package:built_value/built_value.dart';
    
    part 'value.g.dart';
    
    abstract class Value implements Built<Value,ValueBuilder> {
    Value._();
    factory Value([updates(ValueBuilder b)]) = _$Value;
    
    int get id;
    @nullable
    String get description;
    }
  ```
  - As shown above , if a property can be null it MUST be annotated with `@nullable` annotation
    
  
# Generating Serializer for Built Value class : 
  - Declare `static Serializer<Value> get serializer => _$valueSerializer;` inside the Built-Value class 
  - Use `flutter packages pub run build_runner build` to generate serializer for `built-value` class 

# Generating Serializers For `(@SerializersFor)` converting to and from JSON 
  - Manually create a file `serializers.dart` and type-in the below code
    ```
    import 'package:built_value/serializer.dart';
    import 'package:flutter_block_sample/src/models/value.dart';
    
    part 'serializers.g.dart'; //Even if not typed , will be suggested by build_runner
    
    @SerializersFor(const [Value])
    final Serializers serializers = _$serializers;
    ```
  - Run `flutter packages pub  run build_runner watch` from command-line and a serializers.g.dart file will be generated.
  - Once done ,modify the code like below :
    ```
    import 'package:built_value/standard_json_plugin.dart';
    //....
    
    @SerializersFor(const [Value])
    final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
    
    //...
    ```

## Resources 
- [HackerNews](https://github.com/HackerNews/API)



