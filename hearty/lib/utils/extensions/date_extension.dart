extension DateTimeExtension on DateTime {
  DateTime get _now => isUtc ? DateTime.now().toUtc() : DateTime.now();

  bool get isToday {
    final DateTime now = _now;
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final DateTime yesterday = _now.subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool isSameDayWith(DateTime anotherDate) {
    return anotherDate.day == day &&
        anotherDate.month == month &&
        anotherDate.year == year;
  }

  bool isSameMonthWith(DateTime anotherDate) =>
      anotherDate.month == month && anotherDate.year == year;
}
