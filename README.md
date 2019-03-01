# Flutter-samples

A Repo that contains Flutter Sample Apps

## Flutter Bash Profile Config

- Add the below code to bash rc / profile

  ```bash
  ####### FLUTTER BIN SHOULD BE IN PATH #####
  export PATH=$PATH:$HOME/Softwares/flutter/bin

  ####### MAVEN ENV VARIABLES ##########
  export ANDROID_HOME=$HOME//Library/Android/sdk

  ######## REACT NATIVE REQUIREMENT ########
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  ```

## Flutter SDK Repo Move

If we move Flutter SDK to any other REPO  We need to setup the following:

- Remove `.packages` from the project and run the following commands

  ```bash
  flutter doctor
  flutter packages get
  ```

## MateialApp Mandatory params

- Material App needs home property populated , else we will get an assertion error

## Never ever use `functions` over `classes` to make `reusable widget-tree`

- Consider the following "widget" function:

    ```java
        Widget functionWidget({ Widget child}) {
          return Container(child: child);
        }
    ```

    used this way:  

    ```java
        functionWidget(
          child: functionWidget(),
        );
    ```

    And it's class equivalent:

    ```java
        class ClassWidget extends StatelessWidget {
          final Widget child;

          const ClassWidget({Key key, this.child}) : super(key: key);

          @override
          Widget build(BuildContext context) {
            return Container(
              child: child,
            );
          }
        }
    ```

    used like that:

    ```java
        new ClassWidget(
          child: new ClassWidget(),
        );
    ```

    On paper, both seems to do exactly the same thing: Create 2 Container, with one nested into the other. But the reality is slightly different.  

    In the case of functions, the generated widget tree looks like this:

    ```java
        Container
          Container
    ```

    While with classes, the widget tree is:

    ```java
        ClassWidget
          Container
            ClassWidget
              Container
    ```

  This is very important because it radically changes how the framework behaves when updating a widget. Here's a curated list of the differences:

     >Since `ClassWidget` is inserted into the widget tree, it gets associated with an [Element](https://docs.flutter.io/flutter/widgets/Element-class.html) and can, therefore, have a [BuildContext](https://docs.flutter.io/flutter/widgets/BuildContext-class.html) and specify a `Key`. This leads to better performances overall, as `ClassWidget` s can update independently from other widgets.
     >`ClassWidget` can be *hot-reloaded*, `functionWidget` _cannot_. Since the framework doesn't see functionWidget, then when its code change, the framework doesn't know that it has anything to hot-reload.
     >With `functionWidget` you could end up with very weird bug if you ever wanted to use a different function after some updates. This happens because since the framework doesn't see the functionWidget, it might reuse some old widget state instead of creating a new one.
     >By using classes, each part of your layout is always used in the same way: Using constructor. This abstracts the implementation details. It's important because with functions if you ever wanted to change it to a [StatefulWidget](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), it'd be a breaking change.

     _Courtesy : https://stackoverflow.com/questions/53234825/what-is-the-difference-between-functions-and-classes-to-create-widgets/53234826#53234826_

## Useful References

- https://iirokrankka.com/
- http://bizz84.github.io/ | https://codingwithflutter.com/
- https://medium.com/flutter-community
- https://medium.com/flutter-io/do-flutter-apps-dream-of-platform-aware-widgets-7d7ed7b4624d
