import '../point.dart';

abstract class PointRepository {
  /// Retrieves a specific point finding by its ID.
  ///
  /// [id] - The ID of the desired point.
  ///
  /// [cancellation] can be provided to signal the cancellation of the
  /// request. Emitting a value in this stream will trigger the cancellation
  /// process.
  Stream<Point> findOne(String id, [Stream? cancellation]);
}
