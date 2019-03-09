import 'package:flutter/material.dart';
import './inherited_arbitrary_model.dart';
import './arbitrary_data.dart';
import '../../constants.dart';

class InheritedModelDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Model Demo'),
      ),
      body: ArbitraryDataModel(
        data: ArbitraryData(counter: -1, lastMessage: 'Inherited Model Demo'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'Counter value is ${ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.COUNTER)?.data?.counter}'),
            const SizedBox(height: 8.0),
            _AnotherChild(),
          ],
        ),
      ),
    );
  }
}

class _AnotherChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Rebuilding ${this.runtimeType} ${(printStackTrace) ? "\n" + StackTrace.current.toString() : ""}');
    debugPrint('counter = ' +
        ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.NONE)
            .data
            .counter
            .toString());

    TextEditingController controller = TextEditingController();
    return Column(
      children: <Widget>[
        WidgetBuilder((context) {
          return Text(
            'Counter value is ${ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.COUNTER).data.counter}',
          );
        }),
        const SizedBox(height: 8.0),
        WidgetBuilder((context) {
          return Text(
              'Message is ${ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.MESSAGE).data.lastMessage}');
        }),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Increment'),
          onPressed: () {
            ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.NONE)
                .incrementCounter();
          },
        ),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Decrement'),
          onPressed: () {
            ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.NONE)
                .decrementCounter();
          },
        ),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Reset'),
          onPressed: () {
            ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.NONE)
                .reset();
          },
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
        ),
        const SizedBox(height: 8.0),
        FlatButton(
          color: Colors.white,
          child: Text('Save Text'),
          onPressed: () {
            ArbitraryDataModel.of(context, aspect: ArbitraryDataAspect.NONE)
                .message = controller.text.toString();
          },
        ),
      ],
    );
  }
}

typedef Widget WidgetBuilderCallback(BuildContext context);

class WidgetBuilder extends StatelessWidget {
  final WidgetBuilderCallback builder;
  WidgetBuilder(this.builder);
  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
