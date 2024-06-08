import '../entities/share.dart';

/// Encapsulates the logic required to access the [Share] entity.
abstract class ShareRepository {
  /// Constant constructor
  const ShareRepository();

  /// Create a shared `Examination` from a prototype associated
  /// with the given [examinationId].
  /// Start sharing.
  Stream<Share> create({required String examinationId});

  /// Acquire a Shared examination object with the given [id].
  ///
  /// Returns a Future resolved with the identifier of a new examination.
  Stream<String> acquire(String id);
}
