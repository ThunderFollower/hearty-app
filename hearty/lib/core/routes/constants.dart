// A list of routes.

/// The root path.
const rootPath = '/';

/// The top-most path segment for the `/record` route.
const recordPath = '/record';

/// The top-most path segment for the `/record-report` route.
const recordReportPath = '/record-report';

/// The top-most path segment for the `/examination-report` route.
const examinationReportPath = '/examination-report';

/// The path of `/capabilities-guide` route.
const capabilitiesGuidePath = '/capabilities-guide';

/// The top-most path segment for the `/landing` route.
const landingPath = '/landing';

/// The top-most path segment for the `/examination` route.
const examinationPath = '/examination';

/// The top-most path segment for the `/stethoscope` route.
const stethoscopePath = '/stethoscope';

/// The top-most path segment for the `/insufficient-quality` route.
const insufficientQualityPath = '/insufficient-quality';

/// The top-most path segment for the `/marketplace` route.
const marketplacePath = '/marketplace';

/// The top-most path segment for the `/home` route.
const mainRoutePath = '/home';

/// The top-most path segment for the `/onboarding` route.
const onboardingGuidePath = '/onboarding';

/// The top-most path segment for the `/onboarding-initial` route.
const initialOnboardingGuidePath = '/onboarding-initial';

/// The top-most path segment for the `/pre-onboarding` route.
const preOnboardingGuidePath = '/pre-onboarding';

/// The top-most path segment for the `/auth` route.
const authPath = '/auth';

// The top-most path segment for the `/2fa` route.
const twoFactorAuthPath = '/2fa';

// The top-most path segment for the `/recall` route.
const recallPath = '/recall';

// The top-most path segment for the `/update` route.
const updatePath = '/update';

// A list of path/query parameters

/// Defines the name of record id path or query parameter,
/// i.e., `/:recordId` or `?recordId=`.
const recordIdParam = 'recordId';

/// Defines the name of record id path or query parameter,
/// i.e., `/:mutable` or `?mutable=`.
const mutableParam = 'mutable';

/// Defines the name of examination id path or query parameter,
/// i.e., `/:examinationId` or `?examinationId=`.
const examinationIdParam = 'examinationId';

/// Defines the name of record id path or query parameter,
/// i.e., `/:spotNumber` or `?spotNumber=`.
const spotNumberParam = 'spotNumber';

/// Defines the name of record id path or query parameter,
/// i.e., `/:spotName` or `?spotName=`.
const spotNameParam = 'spotName';

/// Defines the name of record id path or query parameter,
/// i.e., `/:bodyPosition` or `?bodyPosition=`.
const bodyPositionParam = 'bodyPosition';

/// Defines the query of the isInitial parameter,
/// i.e.,`?initial=`.
const initialParam = 'initial';

/// Defines the query of the showSuccessNotification parameter,
/// i.e.,`?showSuccessNotification=`.
const showSuccessNotificationParam = 'showSuccessNotification';

/// Defines the name of description path or query parameter,
/// i.e., `/:description` or `?description=`.
const descriptionParam = 'description';
