import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';
import 'core/core.dart';

const _isMarketplaceFeatureEnabled = bool.fromEnvironment(
  'ENABLE_MARKETPLACE_FEATURE',
  defaultValue: true,
);

const _isUpdateFeatureEnabled = bool.fromEnvironment(
  'ENABLE_UPDATE_FEATURE',
  defaultValue: true,
);

/// A class that defines the application's routing.
///
/// The [AppRouter] extends from the auto-generated [$AppRouter], and provides
/// a list of [AutoRoute]s that define the structure of the application's
/// navigation.
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter({
    super.navigatorKey,
    required AutoRouteGuard welcomeGuideGuard,
    required AutoRouteGuard authGuard,
    required AutoRouteGuard subscriptionGuard,
    required AutoRouteGuard updateGuard,
  }) {
    _routes = [
      /// The Root route.
      RedirectRoute(path: rootPath, redirectTo: '/welcome'),

      /// A rote to the Welcome Guide.
      CustomRoute(
        page: WelcomeGuideRoute.page,
        path: '/welcome',
        maintainState: false,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [
          welcomeGuideGuard,
          if (_isUpdateFeatureEnabled) updateGuard,
        ],
      ),

      /// A route to the the landing page.
      /// This page is the first screen users usually see when they open the app.
      CustomRoute(
        page: LandingRoute.page,
        path: landingPath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [if (_isUpdateFeatureEnabled) updateGuard],
      ),

      CustomRoute(
        page: SignInRoute.page,
        path: authPath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the first phase of the sign-up process.
      CustomRoute(
        page: SignUpFirstStepRoute.page,
        path: '/sign-up',
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the final phase of the sign-up process.
      CustomRoute(
        page: SignUpSecondStepRoute.page,
        path: '/sign-up-continue',
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the 2-factor authentication page.
      CustomRoute(
        page: TwoFactorAuthRoute.page,
        path: twoFactorAuthPath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),

      /// A rote to the Onboarding Guide with [slideBottom] transition.
      CustomRoute(
        page: OnboardingGuideRoute.page,
        path: onboardingGuidePath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        maintainState: false,
        usesPathAsKey: true,
        guards: [authGuard],
      ),

      /// A rote to the Onboarding Guide with [slideLeft] transition.
      CustomRoute(
        page: OnboardingInitial.page,
        path: initialOnboardingGuidePath,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        maintainState: false,
        usesPathAsKey: true,
        guards: [authGuard],
      ),

      /// A rote to the page before the Onboarding Guide.
      CustomRoute(
        page: PreOnboardingGuideRoute.page,
        path: preOnboardingGuidePath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        maintainState: false,
        guards: [authGuard],
      ),

      /// Route: Password recovery page
      CustomRoute(
        page: AccountRecoverEmailEnteringRoute.page,
        path: '/recovery',
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// Route: Check Reset Password email page
      CustomRoute(
        page: AccountRecoverEmailSendingRoute.page,
        path: '/recovery-check-email',
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// Route: New password setup page
      CustomRoute(
        page: AccountRecoverPasswordCreationRoute.page,
        path: '/recovery-create-password',
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the main page.
      CustomRoute(
        page: MainRoute.page,
        path: mainRoutePath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [
          authGuard,
          if (_isMarketplaceFeatureEnabled) subscriptionGuard,
        ],
      ),

      /// A route to the detail examination page
      CustomRoute(
        page: ExaminationRoute.page,
        path: '$examinationPath/:$examinationIdParam',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),

      /// A route to the empty report.
      CustomRoute(
        page: EmptyReportRoute.page,
        fullMatch: true,
        path: examinationReportPath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
        usesPathAsKey: true,
      ),

      /// A route to the report of an examination.
      CustomRoute(
        page: ExaminationReportRoute.page,
        fullMatch: true,
        path: '$examinationReportPath/:$examinationIdParam',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
        usesPathAsKey: true,
      ),

      CustomRoute(
        page: ExaminationNotesRoute.page,
        opaque: false,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),
      CustomRoute(
        page: SearchDiseaseRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),
      CustomRoute(
        page: FeedbackRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
      ),
      CustomRoute(
        page: GuideListRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
      ),
      CustomRoute(
        page: ConnectionErrorRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the recall page.
      CustomRoute(
        page: RecallRoute.page,
        path: recallPath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
      CustomRoute(
        page: VisualAnalysisGuideRoute.page,
        path: '/visual-analysis-guide',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),
      CustomRoute(
        page: PendingDocumentsRoute.page,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
      ),
      CustomRoute(
        page: SoundFiltersGuideRoute.page,
        path: '/sound-filter-guide',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),
      CustomRoute(
        page: UserGuideRoute.page,
        path: '/user-guide',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        guards: [authGuard],
      ),

      /// A route to the legal documents.
      CustomRoute(
        page: SignedDocumentsRoute.page,
        path: '/documents-list',
        transitionsBuilder: TransitionsBuilders.slideLeft,
      ),

      // A route to the Account deleted page.
      CustomRoute(
        page: AccountDeletedRoute.page,
        path: '/account-deleted',
        transitionsBuilder: TransitionsBuilders.slideLeft,
      ),

      /// A route to the [ModalMessagePage].
      CustomRoute(
        opaque: false,
        page: ModalMessageRoute.page,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),

      /// A route to the Stethoscope Page.
      CustomRoute(
        page: StethoscopeRoute.page,
        path: stethoscopePath,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
      ),

      /// A route to the Insufficient Quality Page.
      AutoRoute(
        page: InsufficientQualityRoute.page,
        path: '$insufficientQualityPath/:$recordIdParam',
        guards: [authGuard],
      ),

      CustomRoute(
        page: RecordRoute.page,
        path: '$recordPath/:$recordIdParam',
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
        usesPathAsKey: true,
      ),

      CustomRoute(
        page: RecordReportRoute.page,
        path: '$recordReportPath/:$recordIdParam',
        transitionsBuilder: TransitionsBuilders.slideLeft,
        guards: [authGuard],
        usesPathAsKey: true,
      ),

      /// A route to the Marketplace page.
      CustomRoute(
        page: MarketplaceRoute.page,
        path: marketplacePath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),

      /// A route to the Updater page.
      CustomRoute(
        page: UpdaterRoute.page,
        path: updatePath,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
    ];
  }

  late List<AutoRoute> _routes;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => _routes;
}
