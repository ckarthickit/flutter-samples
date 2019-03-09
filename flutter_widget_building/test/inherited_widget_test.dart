import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_building/src/inherited_widget/arbitrary_data.dart';

void main() {
  group('Data', () {
    setUp(() {
      debugPrint('Setting up');
    });
    tearDown(() {
      debugPrint('Tearing down');
    });
    test('== should return true for 2 Data containing same values', () {
      ArbitraryData data1 = ArbitraryData(counter: 1, lastMessage: 'HelloWorld');
      ArbitraryData data2 = ArbitraryData(counter: 1, lastMessage: 'HelloWorld');
      expect(true, data1 == data2);
    });

     test('== should return false for 2 Data containing different values', () {
      ArbitraryData data1 = ArbitraryData(counter:1, lastMessage:"Hello Something");
      ArbitraryData data2 = ArbitraryData(counter:2, lastMessage:"Something Else");
      expect(false, data1 == data2);
    });

    test('!= should return true for 2 Data containing different values', () {
      ArbitraryData data1 = ArbitraryData(counter:1, lastMessage:"Hello Something");
      ArbitraryData data2 = ArbitraryData(counter:2, lastMessage:"Something Else");
      expect(true, data1 != data2);
    });
  });
}
