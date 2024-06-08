import '../entities/share.dart';
import '../share_service.dart';
import '../share_use_case.dart';

/// Implements the business logic of starting share an examination.
class StartSharingInteractor implements StartSharingUseCase {
  /// Create a new [StartSharingInteractor] with the given [sharingService].
  const StartSharingInteractor(
    this.sharingService,
  );

  /// A service dealing with sharing.
  final ShareService sharingService;

  @override
  Stream<Share> execute(String examinationId) =>
      sharingService.startSharing(examinationId: examinationId);
}
