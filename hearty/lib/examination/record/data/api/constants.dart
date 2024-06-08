/// Defines the path for saving records endpoint.
const pathToRecords = '/records';

/// Defines the path to the **/records/{id}** endpoint.
String pathToRecord(String id) => '$pathToRecords/$id';

/// Defines the path to the **/records/{recordId}/analysis** endpoint.
String pathToAcquireRecordQualityStatus(String id) =>
    '$pathToRecords/$id/analysis';
