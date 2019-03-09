enum ArbitraryDataAspect {
  NONE,
  COUNTER,
  MESSAGE,
}

class ArbitraryData {
  int _counter;

  String _lastMessage;

  ArbitraryData({int counter, String lastMessage})
      : _counter = counter ?? 0,
        _lastMessage = lastMessage ?? 'No Message';

  ArbitraryData copyWith({int counter, String lastMessage}) {
    return ArbitraryData(
        counter: counter ?? this.counter,
        lastMessage: lastMessage ?? this.lastMessage);
  }

  get counter {
    return _counter;
  }

  String get lastMessage {
    return _lastMessage ?? 'No Message';
  }

  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! ArbitraryData) return false;
    //Data otherData = other as Data; // LINT => Not testing types might result in null pointer exceptions which will be unexpected for consumers of your class.
    if (other.counter != this.counter) return false;
    if (other.lastMessage != this.lastMessage) return false;
    if (other.hashCode != this.hashCode) return false;
    return true;
  }

  int get hashCode {
    int result = 17;
    result = 37 * result + counter;
    result = 37 * result + _lastMessage.hashCode;
    return result;
  }
}
