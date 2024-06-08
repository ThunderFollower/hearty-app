import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.gr.dart';
import 'auth/auth.dart';
import 'core/views.dart';
import 'examination/examination.dart';
import 'examination/views.dart';
import 'examination/views/connection/config/connection_controller_provider.dart';
import 'examination/views/connection/connection_controller.dart';
import 'examination/views/stethoscope/stethoscope_controller.dart';
import 'recall/config/recall_controller_provider.dart';

class EventWatcher extends ConsumerStatefulWidget {
  const EventWatcher({
    super.key,
    required this.mainRouteName,
    required this.child,
  });

  final String mainRouteName;
  final Widget child;

  @override
  ConsumerState<EventWatcher> createState() => _EventWatcherState();
}

class _EventWatcherState extends ConsumerState<EventWatcher>
    with WidgetsBindingObserver {
  late final ConnectionController _connectionController;

  @override
  void initState() {
    _connectionController = ref.read(connectionControllerProvider.notifier);
    _connectionController.init();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure deep linking is initialized
    ref.listen(tokenControllerProvider, (previous, next) {});
    ref.listen(recallControllerProvider, (previous, next) {});

    return widget.child;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        final isStethoscopeOpen = ref.read(stethoscopeIsOpenProvider);
        if (isStethoscopeOpen) {
          ref.read(stethoscopeStateProvider.notifier).cancel();
          final mode = ref.read(stethoscopeModeProvider);

          final router = ref.read(routerProvider);

          final recordingState = ref.read(
            stethoscopeStateProvider.select((v) => v.recordingState.state),
          );
          if (mode == StethoscopeMode.recording &&
              (recordingState == RecordingStates.recording ||
                  recordingState == RecordingStates.ready)) {
            router.popUntilRouteWithName(ExaminationRoute.name);
            return;
          }

          // Stethoscope is available on the SignInPage
          // that why we should be able to navigate there.
          router.popUntilRouteWithName(
            _isUserLoggedIn(router) ? widget.mainRouteName : LandingRoute.name,
          );
        }
        return;
      case AppLifecycleState.resumed:
        _connectionController.checkConnectivity();
        return;
      default:
        return;
    }
  }

  bool _isUserLoggedIn(StackRouter router) =>
      router.stack.any((element) => element.name == widget.mainRouteName);
}
