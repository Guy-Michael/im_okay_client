class StreamUtils {
  static Stream<T> initStream<T>(
      {Duration? duration,
      required Future<T> Function() func,
      bool invokeWithoutDelay = false}) async* {
    duration ??= Duration(seconds: 5);
    Stream<T> stream = Stream.periodic(duration).asyncMap((event) async => await func());

    if (invokeWithoutDelay) {
      yield await func();
    }
    yield* stream;
  }

  // static Stream<T> initStream<T>(
  // 	{Duration? duration,
  // 	required Future<T> Function() func}) async* {
  // 		duration ??= Duration(seconds: 5);
  // 		Stream<Future<T>> stream =  Stream.periodic(duration, (int _) async => await func())
  // 	}
  // )
}
