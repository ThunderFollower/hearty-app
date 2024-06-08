import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';
import '../constants.dart';

part 'user_agent_dto.freezed.dart';
part 'user_agent_dto.g.dart';

/// Defines Data Transfer Object to track the user agent.
@freezed
class UserAgentDto with _$UserAgentDto implements Serializable<UserAgentDto> {
  /// Construct a new [UserAgentDto] with the given [userAgent].
  const factory UserAgentDto({
    /// User agent string.
    /// example: `"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4)"`
    @JsonKey(name: userAgentHeaderName) required String userAgent,
  }) = _UserAgentDto;

  /// Deserialize [UserAgentDto] from the given [json] object.
  factory UserAgentDto.fromJson(Map<String, dynamic> json) =
      _UserAgentDto.fromJson;
}
