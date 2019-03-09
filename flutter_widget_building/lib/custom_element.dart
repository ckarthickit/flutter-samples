import 'package:flutter/widgets.dart';
import './constants.dart';

class CustomStatefulElement extends StatefulElement {
  CustomStatefulElement(StatefulWidget widget) : super(widget);

  void performRebuild() {
    super.performRebuild();
  }


  /// Update the given child with the given new configuration.
  @protected
  @override
  @mustCallSuper
  Element updateChild(Element child, Widget newWidget, dynamic newSlot) {
    debugPrint('${widget.runtimeType}:updateChild: child=${child?.runtimeType}, newWidget=${newWidget?.runtimeType}, newSlot=$newSlot');
    return super.updateChild(child, newWidget, newSlot);
  }

  @override
  @mustCallSuper
  void update(covariant Widget newWidget){
    super.update(newWidget);
  }
}


class CustomStatelessElement extends StatelessElement {
  CustomStatelessElement(StatelessWidget widget) : super(widget);

  @override
  @mustCallSuper
  void update(StatelessWidget newWidget) {
    debugPrint('${widget.runtimeType}: newWidget=$newWidget, ${(printStackTrace) ? "\n"+ StackTrace.current.toString() : ""}');
    super.update(newWidget);
  }
}