/// SQL migration statement for creating the `Segment` table.
const userMigration003 = [
  /// Structure of the `Segment` table:
  /// - `id`: Unique identifier of the segment (Primary Key).
  /// - `type`: Type of segment; can be 's1', 's2', 's3', or 's4'.
  /// - `start`: Starting point of the segment.
  /// - `end`: Ending point of the segment; must be greater than or equal to `start`.
  /// - `top`: Top boundary of the segment; must be non-negative and greater than or equal to `bottom`.
  /// - `bottom`: Bottom boundary of the segment; must be non-negative.
  /// - `recordId`: Identifier linking to a specific record.
  /// - `freshBefore`: DateTime indicating freshness of the segment.
  /// - `expireAt`: DateTime indicating when the segment's data becomes obsolete or irrelevant.
  '''
      CREATE TABLE Segment (
        id INTEGER PRIMARY KEY,
        type TEXT NOT NULL CHECK (type IN ('s1', 's2', 's3', 's4')),
        start REAL NOT NULL,
        end REAL NOT NULL CHECK (end >= start),
        top INTEGER CHECK(top is NULL OR top >= 0 AND top >= bottom),
        bottom INTEGER CHECK(bottom is NULL OR bottom >= 0),
        recordId TEXT NOT NULL,
        freshBefore DATETIME NOT NULL,
        expireAt DATETIME NOT NULL
      );
  '''
];
