import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';

part 'itunes_app_metadata_query_dto.freezed.dart';
part 'itunes_app_metadata_query_dto.g.dart';

/// A Data Transfer Object (DTO) representing a query to find all iTunes
/// application metadata based on the bundle ID.
@freezed
class ItunesAppMetadataQueryDto
    with _$ItunesAppMetadataQueryDto
    implements Serializable<ItunesAppMetadataQueryDto> {
  const factory ItunesAppMetadataQueryDto({
    /// Specifies the bundle identifier of the application to look up.
    required String bundleId,
  }) = _ItunesAppMetadataQueryDto;

  /// Creates an instance from a JSON map.
  factory ItunesAppMetadataQueryDto.fromJson(Map<String, dynamic> json) =>
      _$ItunesAppMetadataQueryDtoFromJson(json);
}
