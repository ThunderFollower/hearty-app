import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../entities/share.dart';

part 'share_dto.freezed.dart';
part 'share_dto.g.dart';

/// Defines Data Transfer Object for responses that are a [Share] entity.
@freezed
class ShareDto with _$ShareDto implements Share, Serializable<ShareDto> {
  /// Create a new [ShareDto] object.
  const factory ShareDto({
    /// The unique identifier of the created resource — sharing id.
    required String id,

    /// The timestamp of the resource creation.
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// The timestamp of the resource expiration date.
    @JsonKey(name: 'expires_at') required DateTime expiresAt,

    /// The permanent deep link to the resource.
    required Uri link,
  }) = _ShareDto;

  /// Deserialize [ShareDto] from the given [json] object.
  factory ShareDto.fromJson(Map<String, dynamic> json) = _ShareDto.fromJson;
}
