import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app_router.gr.dart';
import 'auth/auth.dart';
import 'core/views.dart';
import 'event_watcher.dart';
import 'examination/views.dart';

const _applicationTitle = 'Hearty';

/// Encapsulates the Stethoscope Application.
class App extends ConsumerWidget {
  /// Construct the Stethoscope application the given [mainRouteName].
  ///
  /// [mainRouteName] should point to a screen with a list of examinations.
  const App._({required this.mainRouteName});

  /// The name of the main route of the application.
  /// It shows to users after the log-in.
  final String mainRouteName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = ref.watch(scaffoldMessengerProvider);
    final router = ref.watch(routerProvider);
    final materialApp = MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      title: _applicationTitle,
      theme: AppThemes.mainTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );

    final circleButtonTheme = CircleButtonTheme(
      data: AppThemes.circleButtonTheme,
      child: materialApp,
    );

    return EventWatcher(
      mainRouteName: mainRouteName,
      child: circleButtonTheme,
    );
  }

  static Future<Widget> create() async {
    await _ensureInitialized();
    const app = App._(mainRouteName: MainRoute.name);
    final localizedApp = _initializeLocalization(app);
    final globalOverlaySupport = _initializeGlobalOverlaySupport(localizedApp);
    return _enabledRiverpod(globalOverlaySupport);
  }

  static Future<void> _ensureInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
  }

  /// Initializes i18n
  static Widget _initializeLocalization(Widget widget) => EasyLocalization(
        supportedLocales: _locales,
        path: 'assets/translations',
        fallbackLocale: _fallbackLocale,
        child: widget,
      );

  static void reportError(Object error, StackTrace stack) {
    _logger.e('Unhandled exception', error, stack);
  }

  /// Enables Riverpod for the entire application
  static Widget _enabledRiverpod(Widget widget) => ProviderScope(
        overrides: [
          mainRouteProvider.overrideWithValue(const MainRoute()),
          tokenInterceptorOverride,
          showStethoscopeInteractorOverride,
          usersDatabaseKeyOverride,
        ],
        child: widget,
      );

  /// Initializes global OverlaySupport.
  static Widget _initializeGlobalOverlaySupport(Widget widget) =>
      OverlaySupport.global(child: widget);
}

const _fallbackLocale = Locale('en');
const _locales = [_fallbackLocale, Locale('uk')];
final _logger = Logger();
