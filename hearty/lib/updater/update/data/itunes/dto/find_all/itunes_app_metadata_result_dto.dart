import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../application_metadata.dart';

part 'itunes_app_metadata_result_dto.freezed.dart';
part 'itunes_app_metadata_result_dto.g.dart';

/// Represents a single result within the iTunes application metadata response.
@freezed
class ItunesAppMetadataResultDto
    with _$ItunesAppMetadataResultDto
    implements ApplicationMetadata {
  const factory ItunesAppMetadataResultDto({
    /// Available version of the application.
    required String version,
  }) = _ItunesAppMetadataResultDto;

  /// Creates an instance from a JSON map.
  factory ItunesAppMetadataResultDto.fromJson(Map<String, dynamic> json) =>
      _$ItunesAppMetadataResultDtoFromJson(json);
}
