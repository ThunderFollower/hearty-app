import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../providers/navigator_global_key_provider.dart';
import '../../views.dart';
import 'open_email_app_interactor.dart';
import 'open_email_app_use_case.dart';

/// Provides an instance of [OpenEmailAppUseCase] using [OpenEmailAppInteractor].
///
/// This provider ensures that the [OpenEmailAppInteractor] is properly initialized
/// with necessary dependencies like navigation key and router.
final openEmailAppProvider = Provider.autoDispose<OpenEmailAppUseCase>(
  (ref) {
    ref.delayDispose();
    return OpenEmailAppInteractor(
      key: ref.watch(navigatorKeyProvider),
      router: ref.watch(routerProvider),
    );
  },
);
