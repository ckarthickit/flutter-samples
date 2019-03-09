import 'package:flutter/material.dart';
import './arbitrary_data.dart';

class ArbitraryDataModel extends StatefulWidget {
  final ArbitraryData data;
  final Widget child;
  ArbitraryDataModel({Key key, this.data, this.child}) : super(key: key);

  @override
  ArbitraryDataModelState createState() => ArbitraryDataModelState(data: data);

  //NOTE: Static functions can be anywhere :)
  static ArbitraryDataModelState of(BuildContext context,
      {ArbitraryDataAspect aspect}) {
    return InheritedModel.inheritFrom<_ArbitraryDataModel>(context,
            aspect: aspect)
        ?.dataState;
  }
}

class ArbitraryDataModelState extends State<ArbitraryDataModel> {
  ArbitraryData data;

  ArbitraryDataModelState({this.data});

  void incrementCounter() {
    setState(() {
      data = this.data.copyWith(counter: data.counter + 1);
    });
  }

  void decrementCounter() {
    setState(() {
      data = this.data.copyWith(counter: data.counter - 1);
    });
  }

  void reset() {
    setState(() {
      data = this.data.copyWith(counter: 0);
    });
  }

  set message(String message) {
    setState(() {
      data = this.data.copyWith(lastMessage: message ?? 'Inherited Model Demo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ArbitraryDataModel(
      dataState: this,
      child: widget.child,
    );
  }
}

//
class _ArbitraryDataModel extends InheritedModel<ArbitraryDataAspect> {
  final ArbitraryDataModelState dataState;

  _ArbitraryDataModel({@required this.dataState, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_ArbitraryDataModel oldWidget) {
    //! We are comparing the Widget data with it's corresponding State's data here
    //! State initially "copies" data from Widget and then mutates it 
    //! So we compare the original "data" from widget against mutatated "data" of the state.
    return dataState.data != oldWidget.dataState.widget.data;
  }

  @override
  bool updateShouldNotifyDependent(
      _ArbitraryDataModel oldWidget, Set<ArbitraryDataAspect> dependencies) {
    ArbitraryData currentData = dataState.data;
    ArbitraryData oldData = oldWidget.dataState.widget.data;
    return (currentData.counter != oldData.counter &&
            dependencies.contains(ArbitraryDataAspect.COUNTER)) ||
        (currentData.lastMessage != oldData.lastMessage &&
            dependencies.contains(ArbitraryDataAspect.MESSAGE));
  }
}
