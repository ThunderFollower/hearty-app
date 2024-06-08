class RecordTileState {
  const RecordTileState({
    this.createdAt,
    this.heartRate,
    this.assetPath,
    this.finding,
    this.spotName,
    this.spotNumber,
    this.bodyPositionName,
    this.error,
  });

  final DateTime? createdAt;
  final int? heartRate;
  final String? finding;
  final String? assetPath;
  final int? spotNumber;
  final String? spotName;
  final String? bodyPositionName;
  final String? error;

  RecordTileState copyWith({
    DateTime? createdAt,
    int? heartRate,
    String? assetPath,
    String? finding,
    int? spotNumber,
    String? spotName,
    String? bodyPositionName,
    String? error,
  }) =>
      RecordTileState(
        createdAt: createdAt ?? this.createdAt,
        heartRate: heartRate ?? this.heartRate,
        assetPath: assetPath ?? this.assetPath,
        finding: finding ?? this.finding,
        spotNumber: spotNumber ?? this.spotNumber,
        spotName: spotName ?? this.spotName,
        bodyPositionName: bodyPositionName ?? this.bodyPositionName,
        error: error ?? this.error,
      );
}
