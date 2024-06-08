/// SQL migration statement for creating the `CardioFinding` and
/// `CardioFindingRelations` tables.
const userMigration001 = [
  ///
  /// `CardioFinding` table has the structure:
  /// - `id`: Primary key of the finding.
  /// - `isFine`: Flag for cardiovascular health. Stored as BOOLEAN (0 or 1).
  /// - `hasMurmur`: Flag for heart murmur presence. BOOLEAN (0 or 1).
  /// - `hasS3`: Flag for third heart sound. BOOLEAN (0 or 1).
  /// - `hasS4`: Flag for fourth heart sound. BOOLEAN (0 or 1).
  /// - `heartRate`: Recorded heart rate. Stored as INTEGER.
  /// - `expireAt`: Timestamp for when the finding should expire. DATETIME.
  '''
      CREATE TABLE CardioFinding (
        id INTEGER PRIMARY KEY,
        isFine BOOLEAN NOT NULL CHECK (isFine IN (0, 1)),
        hasMurmur BOOLEAN NOT NULL CHECK (hasMurmur IN (0, 1)),
        hasS3 BOOLEAN NOT NULL CHECK (hasS3 IN (0, 1)),
        hasS4 BOOLEAN NOT NULL CHECK (hasS4 IN (0, 1)),
        heartRate INTEGER NOT NULL,
        expireAt DATETIME NOT NULL
      );
  ''',

  /// `CardioFindingRelations` table structure:
  /// - `id`: Primary key of the relation.
  /// - `examinationId`: Reference to an associated examination.
  /// - `recordId`: Reference to an associated medical record.
  /// - `expireAt`: Timestamp for when the relation should expire. DATETIME.
  '''
      CREATE TABLE CardioFindingRelations (
        id INTEGER PRIMARY KEY,
        examinationId TEXT,
        recordId TEXT,
        expireAt DATETIME NOT NULL
      );
  '''
];
