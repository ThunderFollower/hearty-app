abstract class DeleteRecordUseCase {
  /// Delete the audio record to by its [id].
  Future<void> execute(String id, [Stream? cancellation]);
}
