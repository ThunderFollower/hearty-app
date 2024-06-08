class ExaminationReportState {
  const ExaminationReportState({
    this.recordIds,
    this.amountOfHeartSpots,
    this.recordsAmount,
  });

  final Iterable<String>? recordIds;

  final int? recordsAmount;
  final int? amountOfHeartSpots;

  ExaminationReportState copyWith({
    Iterable<String>? recordIds,
    int? recordsAmount,
    int? amountOfHeartSpots,
  }) =>
      ExaminationReportState(
        recordIds: recordIds ?? this.recordIds,
        amountOfHeartSpots: amountOfHeartSpots ?? this.amountOfHeartSpots,
        recordsAmount: recordsAmount ?? this.recordsAmount,
      );
}
