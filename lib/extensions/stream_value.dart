import 'package:rxdart/rxdart.dart';
import 'package:pace_app/extensions/general.dart';

class StreamValue<T> {
  late Function _callback;
  final BehaviorSubject<T> _stream = BehaviorSubject();

  Stream<T> get getStreamValue => _stream.stream;

  T? get getLastValue => _stream.value;

  void setValue(T value) {
    _stream.add(value);
    if (_callback.isNotNull) {
      _callback();
    }
  }

  // ignore: use_setters_to_change_properties
  void setCallback(Function callbackValue) {
    _callback = callbackValue;
  }
}
