import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'asset_metadata.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    String? id,
    @Default('record') String type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(0) double longitude,
    @Default(0) double latitude,
    @JsonKey(name: 'asset_metadata') AssetMetadata? assetMetadata,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  const Asset._();

  bool get isNew => id == null;

  String get date => DateFormat.yMMMd().add_jm().format(createdAt.toLocal());
}
