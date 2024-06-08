/// SQL migration statement for creating the `Point` table.
const userMigration002 = [
  /// Structure of the `Point` table:
  /// - `id`: Unique identifier of the point (Primary Key).
  /// - `spot`: Represents the location on the body. Can take values between 0 to 8 inclusive.
  /// - `type`: Type of point. Expected values: [0, 1].
  /// - `bodySide`: Side of the body where the point is located. Expected values: [0, 1].
  /// - `offsetX`: The X-axis offset position of the point on a graphical representation.
  /// - `offsetY`: The Y-axis offset position of the point on a graphical representation.
  /// - `expireAt`: Unix timestamp indicating when the point's data becomes obsolete or irrelevant.
  '''
      CREATE TABLE Point (
        id TEXT PRIMARY KEY,
        spot INTEGER NOT NULL CHECK (spot >= 0 AND spot < 9),
        type INTEGER NOT NULL CHECK (type >= 0 AND type < 2),
        bodySide INTEGER NOT NULL CHECK (bodySide >= 0 AND bodySide < 2),
        offsetX REAL NOT NULL,
        offsetY REAL NOT NULL,
        expireAt DATETIME NOT NULL
      );
  '''
];
