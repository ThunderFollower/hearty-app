/// Encapsulate actions to delete an examination.
abstract class DeleteExaminationUseCase {
  /// Delete an examination with the given [id].
  Future<void> execute(String id);
}
