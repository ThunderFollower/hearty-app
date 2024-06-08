import 'entities/index.dart';

/// Encapsulates the application's business logic
/// to start sharing an examination object.
abstract class StartSharingUseCase {
  /// Execute the use case for the give [id] of an `Examination` object.
  Stream<Share> execute(String id);
}
