import 'dart:async';

extension StreamExtension<T> on Stream<T> {
  Stream<T> ignoreError(Type type) => transform(
        StreamTransformer<T, T>.fromHandlers(
          handleData: (data, sink) => sink.add(data),
          handleError: (error, stackTrace, sink) =>
              _handleError(error, stackTrace, sink, type),
        ),
      );

  void _handleError(
    Object error,
    StackTrace stackTrace,
    EventSink<T> sink,
    Type type,
  ) {
    if (type != error.runtimeType) {
      sink.addError(error, stackTrace);
    }
  }
}
