/// SQL maintenance script to clean up expired records from the `Segment` tables.
const cleanupSegment = [
  /// Delete expired records from the `Segment` table.
  /// Lifespan for `Segment` record is 30 days. Periodically cleanup them
  /// to refresh the cache.
  '''
      DELETE FROM 
        Segment 
      WHERE 
        expireAt <= unixepoch('now');
  ''',
];
