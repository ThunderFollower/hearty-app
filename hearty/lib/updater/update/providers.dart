import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'data/data.dart';
import 'update_service.dart';
import 'update_service_adapter.dart';

/// Provides an auto-disposable instance of [UpdateService].
final updateServiceProvider = Provider.autoDispose<UpdateService>(
  (ref) {
    final repository = ref.watch(applicationMetadataRepositoryProvider);
    return UpdateServiceAdapter(
      packageInfoFuture: ref.watch(packageInfoProvider.future),
      applicationMetadataRepository: repository,
    );
  },
);

/// A provider for fetching the application's package information asynchronously.
///
/// Uses [PackageInfo.fromPlatform] to obtain package information, such as version,
/// from the underlying platform (iOS, Android, etc.).
final packageInfoProvider = FutureProvider.autoDispose<PackageInfo>(
  (ref) => PackageInfo.fromPlatform(),
);
