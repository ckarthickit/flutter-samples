import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './arbitrary_data_model.dart';
import '../../constants.dart';

class ScopedModelDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped Model Demo'),
      ),
      body: ScopedModel<ArbitraryDataModel>(
        model: new ArbitraryDataModel(counter: -1, message: 'Scoped Model'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ScopedModelDescendant<ArbitraryDataModel>(
              builder: (BuildContext context, Widget child,
                  ArbitraryDataModel model) {
                return Text('Counter value is ${model.counter}');
              },
            ),
            const SizedBox(height: 8.0),
            AnotherChild(),
          ],
        ),
      ),
    );
  }
}

class AnotherChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n" + StackTrace.current.toString() : ""}');
    debugPrint('counter = ' +
        ScopedModel.of<ArbitraryDataModel>(context).counter.toString());

    TextEditingController controller = TextEditingController();   
    return Column(
      children: <Widget>[
        ScopedModelDescendant<ArbitraryDataModel>(
          builder:
              (BuildContext context, Widget child, ArbitraryDataModel model) {
            return Text(
              'Counter value is ${model.counter}',
            );
          },
        ),
        const SizedBox(height: 8.0),
        ScopedModelDescendant<ArbitraryDataModel>(
          builder: (BuildContext context, Widget child, ArbitraryDataModel model) {
            return Text('Message is ${model.message}');
          },
        ),
        const SizedBox(height: 8.0),
        ScopedModelDescendant<ArbitraryDataModel>(
          rebuildOnChange: false,
          builder:
              (BuildContext context, Widget child, ArbitraryDataModel model) {
            return FlatButton(
              color: Colors.white,
              child: Text('Increment'),
              onPressed: () {
                model.increment();
              },
            );
          },
        ),
        const SizedBox(height: 8.0),
        ScopedModelDescendant<ArbitraryDataModel>(
          rebuildOnChange: false,
          builder: (BuildContext context, Widget child, ArbitraryDataModel model) {
            return FlatButton(
              color: Colors.white,
              child: Text('Decrement'),
              onPressed: () {
                model.decrement();
              },
            );
          },
        ),
        const SizedBox(height: 8.0),
        ScopedModelDescendant<ArbitraryDataModel>(
          rebuildOnChange: false,
          builder: (BuildContext context, Widget child, ArbitraryDataModel model) {
            return FlatButton(
              color: Colors.white,
              child: Text('Reset'),
              onPressed: () {
                model.reset();
              },
            );
          },
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
        ),
        const SizedBox(height: 8.0),
        ScopedModelDescendant<ArbitraryDataModel>(
          rebuildOnChange: false,
          builder: (BuildContext context, Widget child, ArbitraryDataModel model) {
            return FlatButton(
              color: Colors.white,
              child: Text('Save Text'),
              onPressed: () {
                model.message = controller.text.toString();
              },
            );
          },
        ),
      ],
    );
  }
}
