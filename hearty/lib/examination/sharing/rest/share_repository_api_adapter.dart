import '../../../core/core.dart';
import '../entities/share.dart';
import '../ports/share_repository.dart';
import 'constants.dart';
import 'dtos/index.dart';

/// Implements a port of [ShareRepositoryApiAdapter] that uses
class ShareRepositoryApiAdapter implements ShareRepository {
  /// Construct a new adapter that uses the given [dataSource]
  /// for HTTP requests.
  const ShareRepositoryApiAdapter(
    this.dataSource,
    this.cancelable,
  );

  /// A data source access to private API.
  final HttpDataSource dataSource;

  /// A cancelable object to cancel HTTP requests.
  final Cancelable cancelable;

  @override
  Stream<Share> create({required String examinationId}) async* {
    final body = CreateShareDto(examinationId: examinationId);
    final response = await dataSource.post<ShareDto>(
      pathToStartSharing,
      body: body,
      cancelable: cancelable,
      deserializer: ShareDto.fromJson,
    );

    yield response;
  }

  @override
  Stream<String> acquire(String id) async* {
    final response = await dataSource.post<AcquireResultDto>(
      pathToAcquireSharedExamination(id),
      cancelable: cancelable,
      deserializer: AcquireResultDto.fromJson,
    );

    yield response.examinationId;
  }
}
