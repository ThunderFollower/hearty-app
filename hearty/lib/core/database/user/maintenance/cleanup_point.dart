/// SQL maintenance script to clean up expired records from the `Point` table.
const cleanupCardioPoint = [
  /// Delete expired records from the `Point` table.
  /// Lifespan for `Point` record is 30 days. Periodically cleanup them
  /// to refresh the cache.
  '''
      DELETE FROM 
        Point 
      WHERE 
        expireAt <= unixepoch('now');
  ''',
];
