/// Defines the path to the sharing functionality endpoint.
const pathToStartSharing = '/share';

/// Defines the path to the **/share/{shareId}** endpoint.
String pathToAcquireSharedExamination(String id) => 'share/$id';
