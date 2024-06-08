import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_router.gr.dart';
import '../../../auth/account/auth_profile_service_provider.dart';
import '../../../auth/biometric/config/biometric_service_provider.dart';
import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../examination.dart';
import '../../sharing/providers/share_service_provider.dart';
import '../examination/index.dart';
import 'content/received/list/received_list_controller.dart';
import 'main_page_controller.dart';
import 'main_page_controller_adapter.dart';

/// Defines provider for the [MainPageController].
final mainPageControllerProvider = Provider.autoDispose<MainPageController>(
  (ref) {
    final controller = ref.watch(
      examinationStateProvider.notifier,
    );

    final result = MainPageControllerAdapter(
      biometricInitializer: ref.read(biometricServiceProvider).init,
      shareService: ref.watch(shareServiceProvider),
      router: ref.watch(routerProvider),
      mainRoute: ref.watch(mainRouteProvider),
      usedLinkMessageRoute: unusedLinkRoute,
      invalidLinkRoute: invalidLinkRoute,
      examinationRoute: (String id) => ExaminationRoute(examinationId: id),
      asyncPreferences: ref.read(sharedPreferencesProvider.future),
      authProfileService: ref.watch(authProfileServiceProvider),
      receivedListController: ref.watch(receivedListStateProvider.notifier),
      examinationController: controller,
      showStethoscope: ref.watch(showStethoscopeProvider),
    );
    ref.onDispose(result.dispose);
    return result;
  },
);
