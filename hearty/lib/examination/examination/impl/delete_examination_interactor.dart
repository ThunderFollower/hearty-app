import '../index.dart';

/// Orchestrate deleting of an examination
class DeleteExaminationInteractor implements DeleteExaminationUseCase {
  /// Create a new [DeleteExaminationInteractor] with the given [service].
  DeleteExaminationInteractor(this.service);

  /// An instance of a service managing examination business entities.
  final ExaminationService service;

  @override
  Future<void> execute(String id) => service.deleteOne(id);
}
