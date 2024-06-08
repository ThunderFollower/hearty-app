import 'constants.dart';

/// Returns URI to the `/record/*?mutable=` routes.
Uri resolveRecordUri(String recordId, {bool? mutable}) => Uri(
      path: '$recordPath/$recordId',
      queryParameters: {if (mutable != null) mutableParam: mutable.toString()},
    );

/// Returns URI to the `/record/*` routes.
Uri resolveRecordReportUri(
  String recordId, {
  required int spotNumber,
  required String spotName,
  required String bodyPosition,
}) =>
    Uri(
      path: '$recordReportPath/$recordId',
      queryParameters: {
        spotNumberParam: spotNumber.toString(),
        spotNameParam: spotName,
        bodyPositionParam: bodyPosition,
      },
    );

/// Returns URI to the `/capabilities-guide` route.
Uri resolveCapabilitiesGuideUri() => Uri(path: capabilitiesGuidePath);

/// Returns URI to the `/examination-report/:examinationId` routes.
Uri resolveExaminationReportUri([String? examinationId]) {
  final secondSegment = examinationId == null ? '' : '/$examinationId';
  return Uri(path: examinationReportPath + secondSegment);
}

/// Returns URI to the `/examination/:examinationId` routes.
Uri resolveExaminationDetailUri(String examinationId) =>
    Uri(path: '$examinationPath/$examinationId');

/// Returns URI to the `/stethoscope?recordId=` routes.
Uri stethoscopePathResolver([String? recordId]) => Uri(
      path: stethoscopePath,
      queryParameters: {if (recordId != null) recordIdParam: recordId},
    );

/// Returns URI to the `/insufficient-quality/:recordId` routes.
Uri resolveInsufficientQualityUri(String recordId) =>
    Uri(path: '$insufficientQualityPath/$recordId');

/// Returns URI to the `/onboarding?isInitial=` routes
Uri resolveOnboardingGuideUri({bool? initial}) => Uri(
      path: onboardingGuidePath,
      queryParameters: {
        if (initial != null) initialParam: initial.toString(),
      },
    );

/// Returns URI to the `/2fa?showSuccessNotification=` routes
Uri resolveTwoFactorAuthUri({bool? showSuccessNotification}) => Uri(
      path: twoFactorAuthPath,
      queryParameters: {
        if (showSuccessNotification != null)
          showSuccessNotificationParam: showSuccessNotification.toString(),
      },
    );

/// Returns URI to the `/recall?description=` routes
Uri resolveRecallUri({
  String? description,
}) =>
    Uri(
      path: recallPath,
      queryParameters: {
        if (description != null) descriptionParam: description,
      },
    );
