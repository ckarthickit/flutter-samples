# flutter_block_sample

A Flutter project that Demos about BLoC pattern .

- We will be using Hacker New API to demo this

## Notes
- Use `https://charafau.github.io/json2builtvalue/` to built-value class from a JSON
- Use `flutter packages pub run build_runner build` to generate part file for built-value class
  - Type the following "minimal" abstract class declaration in a file before we run build_runner
    ```
    import 'package:built_value/built_value.dart';
    abstract class Value implements Built<Value,ValueBuilder> {
    }
    ```
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

## Resources 
- [HackerNews](https://github.com/HackerNews/API)



