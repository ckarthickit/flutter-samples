import 'package:flutter/material.dart';
import '../../custom_element.dart';
import '../../constants.dart';
import './arbitrary_data.dart';

class InheritedWidgetDemoPage2 extends StatelessWidget {
  @override
  StatelessElement createElement() => CustomStatelessElement(this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget Demo2'),
      ),
      body: Container(
        child: Page(
          pageData: ArbitraryData(counter: -1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Counter value is ${Page.of(context)?.data?.counter}'),
              const SizedBox(height: 8.0),
              AnotherChild(),
            ],
          ),
        ),
      ),
    );
  }
}

class Page extends StatefulWidget {
  final ArbitraryData pageData;
  final Widget child;
  Page({this.pageData, this.child});

  @override
  PageState createState() => PageState();

  static PageState of(BuildContext context) {
    final _InheritedPage inheritedPage = context.inheritFromWidgetOfExactType(_InheritedPage);
    return inheritedPage?.pageState;
  }
}

class PageState extends State<Page> {

  ArbitraryData get data {
    return widget.pageData;
  }

  void incrementCounter() {
    setState(() {
      this.data.incrementCounter();
    });
  }

  void decrementCounter() {
    setState(() {
      this.data.decrementCounter();
    });
  }

  void setMessage(String message) {
    setState(() {
      this.data.lastMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedPage(
      pageState: this,
      child: widget.child,
    );
  }
}

class _InheritedPage extends InheritedWidget {
  final PageState pageState;
  const _InheritedPage({
    Key key,
    @required this.pageState,
    @required Widget child,
  }): super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedPage oldWidget) {
    //return pageState.widget.pageData != oldWidget.pageState.widget.pageData;
    return true;
  }

}



class AnotherChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n"+ StackTrace.current.toString() : ""}');
    Page.of(context);
    debugPrint('counter = ' + Page.of(context).data.counter.toString());
    return Column(
      children: <Widget>[
        Text('Counter value is ${Page.of(context).data.counter}',),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Increment'),
          onPressed: () {
           PageState state =Page.of(context);
           state.incrementCounter();
          },
        )
      ],
    );
  }
}


