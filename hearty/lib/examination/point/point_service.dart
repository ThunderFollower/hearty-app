import 'point.dart';

/// An abstract class that defines the business logic operations for managing
/// the [Point] domain model.
abstract class PointService {
  /// Retrieves a point by given [id].
  ///
  /// The [cancellation] can be provided to signal the cancellation of
  /// the request. Emitting a value in this stream will trigger the cancellation.
  Stream<Point> findOne(String id, [Stream? cancellation]);
}
