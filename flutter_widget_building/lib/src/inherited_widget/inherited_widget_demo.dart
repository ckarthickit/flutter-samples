import 'package:flutter/material.dart';
import '../../custom_element.dart';
import './arbitrary_data.dart';

class InheritedWidgetDemoPage extends StatelessWidget {
  @override
  StatelessElement createElement() => CustomStatelessElement(this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget Demo'),
      ),
      body: Container(
        child: Page(
          pageData: ArbitraryData(counter: -1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Counter value is ${Page.of(context)?.counter}'),
              const SizedBox(height: 8.0),
              AnotherChild(),
            ],
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final ArbitraryData pageData;
  final Widget child;
  Page({this.pageData, this.child});

  @override
  Widget build(BuildContext context) {
    return _InheritedPage(
      pageData: pageData,
      child: child,
    );
  }
   
  static ArbitraryData of(BuildContext context) {
    final _InheritedPage inheritedPage = context.inheritFromWidgetOfExactType(_InheritedPage);
    return inheritedPage?.pageData;
  }
}

class _InheritedPage extends InheritedWidget {
  final ArbitraryData pageData;
  const _InheritedPage({
    Key key,
    @required this.pageData,
    @required Widget child,
  }): super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedPage oldWidget) {
    // return pageData != oldWidget.pageData;
    return true;
  }

}



class AnotherChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Counter value is ${Page.of(context).counter}',),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Increment'),
          onPressed: () {
            Page.of(context).incrementCounter();
          },
        )
      ],
    );
  }
}


