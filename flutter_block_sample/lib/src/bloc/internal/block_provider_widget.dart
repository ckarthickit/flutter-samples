import 'package:flutter/material.dart';
import 'package:flutter_block_sample/src/bloc/internal/block_base.dart';

class BlocProviderWidget<T extends BaseBloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProviderWidget(
    {
      Key key,
      @required this.bloc,
      @required this.child
    }
  ): super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocProviderWidgetState();

  static BlocProviderWidget<T> of<T extends BaseBloc> (BuildContext context) {
    final runtimeType = _runtimeTypeObjectOf<BlocProviderWidget<T>>();
    BlocProviderWidget<T> provider = context.ancestorWidgetOfExactType(runtimeType);
    return provider;
  }

  /**
   * This function gives back "runtimeType-object" of the passed generic 
   * at runtime. 
   * We need this function as this same information cannot be represented at compile-time currently.
   */
  static Type _runtimeTypeObjectOf<T>() { 
    return T;
  }
}

class _BlocProviderWidgetState extends State<BlocProviderWidget<BaseBloc>> {

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

}

