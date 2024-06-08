import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';

part 'device_dto.freezed.dart';
part 'device_dto.g.dart';

@freezed
class DeviceDto with _$DeviceDto implements Serializable<DeviceDto> {
  const factory DeviceDto({
    /// UUID; Unique device/installation identifier.
    /// example: `"3fa85f64-5717-4562-b3fc-2c963f66afa6"`
    @JsonKey(name: 'device_identifier') required String deviceIdentifier,
  }) = _DeviceDto;

  /// Deserialize [DeviceDto] from the given [json] object.
  factory DeviceDto.fromJson(Map<String, dynamic> json) = _DeviceDto.fromJson;
}
