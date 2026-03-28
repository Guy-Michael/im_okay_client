import 'dart:async';

class StreamUtils {
  static Stream<T> initStream<T>(
      {Duration duration = const Duration(seconds: 5), required Future<T> Function() func}) async* {
    while (true) {
      T value = await func();
      yield value;
      await Future.delayed(duration);
    }
  }

  static StreamController<T> initStreamController<T>(
      {required Duration duration, required Future<T> Function() func}) {
    Stream<T> stream = initStream<T>(func: func, duration: duration);
    StreamController<T> controller = StreamController<T>();
    controller.addStream(stream);
    return controller;
  }
}
