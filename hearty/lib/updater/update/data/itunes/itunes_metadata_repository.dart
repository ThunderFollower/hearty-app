import 'dart:convert';

import '../../../../core/core.dart';
import '../application_metadata.dart';
import '../application_metadata_repository.dart';
import 'dto/dto.dart';

/// A repository implementation that fetches application metadata from iTunes.
class ItunesMetadataRepository implements ApplicationMetadataRepository {
  const ItunesMetadataRepository({
    required this.dataSource,
  });

  /// The data source used for accessing the iTunes API.
  final HttpDataSource dataSource;

  static const _pathToLookup = '/lookup';

  @override
  Stream<Iterable<ApplicationMetadata>> findAll(
    String packageName, [
    Stream<void>? cancellation,
  ]) async* {
    try {
      final query = ItunesAppMetadataQueryDto(bundleId: packageName);
      final response = await dataSource.get<String>(
        _pathToLookup,
        queryParameters: query,
      );
      final parsedResponse = _parse(response);
      yield parsedResponse.results ?? [];
    } on CanceledException catch (_) {
      // This catch block is intentionally left empty to handle cancellation.
    }
  }

  /// Parses the given JSON [data] into a [ItunesAppMetadataResponseDto].
  ItunesAppMetadataResponseDto _parse(String data) {
    final decoded = json.decode(data) as Map<String, dynamic>;
    return ItunesAppMetadataResponseDto.fromJson(decoded);
  }
}
