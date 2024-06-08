import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../utils/utils.dart';
import 'asset_type.dart';
import 'cache_repository.dart';
import 'entities/asset.dart';
import 'entities/asset_metadata.dart';
import 'local/geolocation_service.dart';
import 'rest/asset_repository.dart';

final assetServiceProvider =
    Provider.autoDispose<AssetService>((ref) => AssetService(ref));

class AssetService {
  final Ref _ref;
  late final AssetRepository _repository;
  late final CacheRepository _cacheRepository;
  late final GeolocationService _geolocationService;

  AssetService(this._ref) {
    _repository = _ref.read(assetRepositoryProvider);
    _cacheRepository = _ref.read(cacheRepositoryProvider);
    _geolocationService = _ref.read(geolocationService);
  }

  Future<Asset> save({
    required File assetFile,
    AssetType type = AssetType.record,
    Asset? asset,
  }) async {
    final newAsset = await buildAssetFrom(asset);
    final userAgent = await UserAgentBuilder.build();
    final savedAsset = await _repository.save(
      asset: newAsset,
      file: assetFile,
      userAgent: userAgent,
    );

    final bytes = await assetFile.readAsBytes();
    final name = _buildCachedAssetName(savedAsset);
    await _cacheRepository.save(bytes: bytes, name: name);

    return savedAsset;
  }

  Future<Asset> buildAssetFrom(Asset? asset) async {
    final position = await _geolocationService.getLocation();
    final latitude = position?.latitude ?? 0;
    final longitude = position?.longitude ?? 0;
    final isDeclickerActivated = _ref.read(declickerSettingProvider);

    if (asset == null) {
      return Asset(
        createdAt: DateTime.now().toUtc(),
        latitude: latitude,
        longitude: longitude,
        assetMetadata:
            AssetMetadata(isDeclickerActivated: isDeclickerActivated),
      );
    }

    final assetMetadata = asset.assetMetadata
        ?.copyWith(isDeclickerActivated: isDeclickerActivated);
    return asset.copyWith(
      createdAt: DateTime.now().toUtc(),
      latitude: latitude,
      longitude: longitude,
      assetMetadata: assetMetadata,
    );
  }

  Future<String> getCachedAssetUri({required Asset asset}) async {
    final name = _buildCachedAssetName(asset);
    return await _cacheRepository.getUri(name) ??
        await _cacheAsset(asset: asset);
  }

  Future<String> _cacheAsset({required Asset asset}) async {
    final bytes = await _repository.getData(asset.id!);
    final name = _buildCachedAssetName(asset);
    return _cacheRepository.save(bytes: bytes, name: name);
  }

  String _buildCachedAssetName(Asset savedAsset) =>
      '${savedAsset.id}_${savedAsset.createdAt}';

  Future<File?> getCachedAsset({required Asset asset}) async {
    final name = _buildCachedAssetName(asset);
    return await _cacheRepository.getFile(name);
  }
}
