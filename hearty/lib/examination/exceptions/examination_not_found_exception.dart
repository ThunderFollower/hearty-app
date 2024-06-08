class ExaminationNotFoundException implements Exception {
  const ExaminationNotFoundException();

  @override
  String toString() => 'There is no examination.';
}
