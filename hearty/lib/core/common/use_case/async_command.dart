/// An abstraction representing an asynchronous command that performs a single
/// unit of work.
abstract class AsyncCommand<T> {
  /// Executes the command and performs the necessary work.
  ///
  /// Returns a `Future` that completes when the command has finished executing.
  Future<T> execute();
}
