import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../impl/start_sharing_interactor.dart';
import '../providers/share_service_provider.dart';
import '../share_use_case.dart';

/// Provide an instance of the [StartSharingUseCase].
final startSharingProvider = Provider.autoDispose<StartSharingUseCase>(
  (ref) => StartSharingInteractor(ref.watch(shareServiceProvider)),
);
