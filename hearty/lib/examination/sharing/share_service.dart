import 'entities/share.dart';

/// Encapsulates dealing with the Sharing logic.
abstract class ShareService {
  /// Constant constructor.
  const ShareService();

  /// Start share an examination with the given [examinationId].
  Stream<Share> startSharing({required String examinationId});

  /// Add a new Shared Examination by its [id].
  ///
  /// Usually, the Shared Examination is received via a deep link.
  void add(String id);

  /// Select Shared Examinations that the user can take over.
  Stream<String> selectPending();

  /// Take over a Shared Examination with the given [id].
  ///
  /// Returns a Stream resolved with the identifier of a new examination.
  Stream<String> acquire(String id);
}
