/// SQL maintenance script to clean up expired records from the `CardioFinding`
/// and `CardioFindingRelations` tables.
const cleanupCardioFinding = [
  /// Delete expired records from the `CardioFinding` table.
  /// Lifespan for `CardioFinding` record is 30 days. Periodically cleanup them
  /// to refresh the cache.
  '''
      DELETE FROM 
        CardioFinding 
      WHERE 
        expireAt <= unixepoch('now');
  ''',

  /// Delete records that expired 30 days ago from the `CardioFindingRelations`
  /// table.
  /// Despite some records may have been expired, they are still sufficient for
  /// caching. Relations record are constantly updated. If they are too 'old',
  /// this can mean that they are unused.
  '''
      DELETE FROM 
        CardioFindingRelations 
      WHERE 
        expireAt <= unixepoch('now', '-30 days');
  '''
];
