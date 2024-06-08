import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_identifier.freezed.dart';
part 'device_identifier.g.dart';

@freezed
class DeviceIdentifier with _$DeviceIdentifier {
  const factory DeviceIdentifier({
    @JsonKey(name: 'device_identifier') required String deviceIdentifier,
  }) = _DeviceIdentifier;

  factory DeviceIdentifier.fromJson(Map<String, dynamic> json) =>
      _$DeviceIdentifierFromJson(json);
}
