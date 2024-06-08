class ExaminationTileState {
  const ExaminationTileState({
    this.iconPath,
    this.priorFinding,
    this.amountOfHeartRecords,
    this.amountOfHeartSpots,
    this.amountOfLungRecords,
    this.amountOfLungSpots,
    this.modificationDate,
    this.title,
    this.from,
  });

  final String? iconPath;
  final String? priorFinding;
  final String? title;
  final String? modificationDate;
  final int? amountOfHeartRecords;
  final int? amountOfLungRecords;
  final int? amountOfHeartSpots;
  final int? amountOfLungSpots;
  final String? from;

  ExaminationTileState copyWith({
    String? iconPath,
    String? priorFinding,
    String? title,
    int? amountOfHeartSpots,
    int? amountOfHeartRecords,
    int? amountOfLungSpots,
    int? amountOfLungRecords,
    String? modificationDate,
    String? from,
  }) =>
      ExaminationTileState(
        iconPath: iconPath ?? this.iconPath,
        priorFinding: priorFinding ?? this.priorFinding,
        amountOfHeartSpots: amountOfHeartSpots ?? this.amountOfHeartSpots,
        amountOfHeartRecords: amountOfHeartRecords ?? this.amountOfHeartRecords,
        amountOfLungSpots: amountOfLungSpots ?? this.amountOfLungSpots,
        amountOfLungRecords: amountOfLungRecords ?? this.amountOfLungRecords,
        title: title ?? this.title,
        modificationDate: modificationDate ?? this.modificationDate,
        from: from ?? this.from,
      );
}
