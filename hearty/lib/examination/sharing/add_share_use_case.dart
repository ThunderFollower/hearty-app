/// Encapsulates business logic of adding a Share.
abstract class AddShareUseCase {
  const AddShareUseCase();

  /// Execute this use case with the give [id] of the Shared Examination.
  Future<void> execute(String id);
}
