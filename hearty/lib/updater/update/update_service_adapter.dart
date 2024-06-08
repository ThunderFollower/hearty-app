import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:rxdart/rxdart.dart';

import 'data/data.dart';
import 'update_service.dart';

/// An adapter implementation of [UpdateService] that checks for application updates.
class UpdateServiceAdapter implements UpdateService {
  /// Constructs an instance of [UpdateServiceAdapter].
  ///
  /// Requires a future that resolves to [PackageInfo] containing the current package's info
  /// and an [ApplicationMetadataRepository] to query for the latest application metadata.
  const UpdateServiceAdapter({
    required this.packageInfoFuture,
    required this.applicationMetadataRepository,
  });

  /// A future that resolves to the current package's information.
  final Future<PackageInfo> packageInfoFuture;

  /// The repository used to query for application metadata.
  final ApplicationMetadataRepository applicationMetadataRepository;

  @override
  Stream<bool> observeUpdate() async* {
    final packageInfo = await packageInfoFuture;
    final handler = _ApplicationMetadataHandler(packageInfo.version);

    yield* applicationMetadataRepository
        .findAll(packageInfo.packageName)
        // Take the last emission from the findAll stream.
        .takeLast(1)
        .map(handler.handleList);
  }
}

/// Handles the logic to determine if an update is available by comparing
/// the current application version against the latest version available.
class _ApplicationMetadataHandler {
  /// The current version of the application.
  final String version;

  _ApplicationMetadataHandler(this.version);

  /// Compares [metadataList] to the current version to determine if an update is available.
  ///
  /// Returns `true` if an update is available, otherwise `false`.
  bool handleList(Iterable<ApplicationMetadata> metadataList) {
    if (metadataList.isEmpty) return false;

    final currentVersion = Version.parse(version);
    final updateVersion = Version.parse(metadataList.first.version);

    return updateVersion > currentVersion;
  }
}
