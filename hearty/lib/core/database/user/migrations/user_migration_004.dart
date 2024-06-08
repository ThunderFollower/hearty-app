/// SQL migration that adds 'unsegmentable' value.
const userMigration004 = [
  // Step 1: Create a new table with the updated constraint
  '''
    CREATE TABLE NewSegment (
      id INTEGER PRIMARY KEY,
      type TEXT NOT NULL CHECK (type IN ('unsegmentable', 's1', 's2', 's3', 's4')),
      start REAL NOT NULL,
      end REAL NOT NULL CHECK (end >= start),
      top INTEGER CHECK(top is NULL OR top >= 0 AND top >= bottom),
      bottom INTEGER CHECK(bottom is NULL OR bottom >= 0),
      recordId TEXT NOT NULL,
      freshBefore DATETIME NOT NULL,
      expireAt DATETIME NOT NULL
    );
  ''',

  // Step 2: Copy all data from the old table to the new one
  '''
    INSERT INTO NewSegment (id, type, start, end, top, bottom, recordId, freshBefore, expireAt)
    SELECT id, type, start, end, top, bottom, recordId, freshBefore, expireAt FROM Segment;
  ''',

  // Step 3: Drop the old table
  '''
    DROP TABLE Segment;
  ''',

  // Step 4: Rename the new table to the old table name
  '''
    ALTER TABLE NewSegment RENAME TO Segment;
  '''
];
