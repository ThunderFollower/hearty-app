import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_metadata.freezed.dart';
part 'asset_metadata.g.dart';

@freezed
class AssetMetadata with _$AssetMetadata {
  const factory AssetMetadata({
    @JsonKey(name: 'asset_metadata_id') String? id,
    @JsonKey(name: 'is_declicker_activated')
    @Default(false)
    bool isDeclickerActivated,
  }) = _AssetMetadata;

  factory AssetMetadata.fromJson(Map<String, dynamic> json) =>
      _$AssetMetadataFromJson(json);
}
