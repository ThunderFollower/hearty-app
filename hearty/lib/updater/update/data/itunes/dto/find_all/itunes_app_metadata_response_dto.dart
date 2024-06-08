import 'package:freezed_annotation/freezed_annotation.dart';

import 'itunes_app_metadata_result_dto.dart';

part 'itunes_app_metadata_response_dto.freezed.dart';
part 'itunes_app_metadata_response_dto.g.dart';

/// A DTO for the response obtained from querying iTunes application metadata.
@freezed
class ItunesAppMetadataResponseDto with _$ItunesAppMetadataResponseDto {
  const factory ItunesAppMetadataResponseDto({
    /// Specifies a list of found application metadata.
    @JsonKey(includeIfNull: false) List<ItunesAppMetadataResultDto>? results,
  }) = _ItunesAppMetadataResponseDto;

  /// Creates an instance from a JSON map.
  factory ItunesAppMetadataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ItunesAppMetadataResponseDtoFromJson(json);
}
