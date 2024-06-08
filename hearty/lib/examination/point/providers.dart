import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';
import 'data/providers.dart';
import 'point_service.dart';
import 'point_service_impl.dart';

/// A provider for [PointService].
final pointServiceProvider = Provider.autoDispose<PointService>(
  (ref) {
    // It will delay the disposal of the provider by 1 minute, ensuring that
    // it won't get disposed immediately after it's no longer in use.
    // Instead, it will have a grace period of 1 minute during which it can be
    // reused before it's disposed
    ref.delayDispose(const Duration(minutes: 1));
    final service = PointServiceImpl(ref.watch(pointRepositoryProvider));
    ref.onDispose(service.dispose);
    return service;
  },
);
