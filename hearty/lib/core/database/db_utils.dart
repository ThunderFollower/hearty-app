/// Converts a [bool] to an [int]. Returns `1` if [value] is true, otherwise `0`.
// ignore: avoid_positional_boolean_parameters
int boolToInt(bool value) => value ? 1 : 0;

/// Converts an [int] to a [bool]. Returns `true` if [value] is `1`, otherwise `false`.
bool intToBool(int value) => value == 1;

/// Converts a [DateTime] object to a Unix timestamp (seconds since 1970-01-01 00:00:00 UTC).
int dateTimeToUnixTimestamp(DateTime value) =>
    (value.toUtc().millisecondsSinceEpoch / 1000).round();

/// Converts a Unix timestamp (seconds since 1970-01-01 00:00:00 UTC) to a [DateTime] object.
DateTime unixTimestampToDateTime(int value) =>
    DateTime.fromMillisecondsSinceEpoch(
      value * 1000,
      isUtc: true,
    );
