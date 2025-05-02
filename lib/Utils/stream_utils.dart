class StreamUtils {
  static Stream<T> initStream<T>(
      {Duration duration = const Duration(seconds: 5), required Future<T> Function() func}) async* {
    while (true) {
      T value = await func();
      yield value;
      await Future.delayed(duration);
    }
  }
}
