import 'package:scoped_model/scoped_model.dart';

class ArbitraryDataModel extends Model {
  int _counter;
  String _message;
  ArbitraryDataModel({int counter, String message})
      : this._counter = counter ?? 0,
        this._message = message ?? '';

  int get counter {
    return _counter;
  }

  set message(String message) {
    _message = message ?? "";
    notifyListeners();
  }
  String get message {
    return _message;
  }
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter --;
    notifyListeners();
  }      

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
