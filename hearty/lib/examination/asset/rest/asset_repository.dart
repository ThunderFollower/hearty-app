import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../entities/asset.dart';

final assetRepositoryProvider =
    Provider.autoDispose<AssetRepository>((ref) => AssetRepository(ref));

class AssetRepository {
  static const _path = '/v2/files';

  final Ref _ref;
  late final Dio _api;

  AssetRepository(this._ref) {
    _api = _ref.read(apiProvider);
  }

  Future<Uint8List> getData(String id) async {
    final options = Options(
      responseType: ResponseType.bytes,
      headers: {'Accept': 'application/octet-stream'},
    );
    final response = await _api.get<Uint8List>('$_path/$id', options: options);
    return response.data!;
  }

  Future<Asset> save({
    required Asset asset,
    required File file,
    required String userAgent,
  }) async {
    final assetJson = asset.toJson();
    var method = _api.patch;
    String path = '$_path/${asset.id}';
    if (asset.isNew) {
      assetJson.remove('id');
      method = _api.post;
      path = _path;
    }
    final multipartFile = await MultipartFile.fromFile(file.path);
    assetJson.putIfAbsent('asset', () => multipartFile);
    final assetMetadata = assetJson.remove('asset_metadata');
    final metadataJson = json.encode(assetMetadata);
    assetJson.putIfAbsent('asset_metadata', () => metadataJson);
    final data = FormData.fromMap(assetJson);
    final options = Options(
      headers: {
        'User-Agent': userAgent,
        'Accept': 'application/json',
      },
    );
    final response = await method<Map<String, dynamic>>(
      path,
      data: data,
      options: options,
    );
    return Asset.fromJson(response.data!);
  }
}
