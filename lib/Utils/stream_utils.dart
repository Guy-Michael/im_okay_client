class StreamUtils {
  static Stream<T> initStreamWithInitial<T>(Duration duration, Future<T> Function() func) async* {
    Stream<T> stream = Stream.periodic(duration).asyncMap((event) async => await func());
    yield await func();
    yield* stream;
  }
}
