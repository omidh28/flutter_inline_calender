bool isSameDate(DateTime a, DateTime b) {
  return removeTimeFrom(a) == removeTimeFrom(b);
}

DateTime removeTimeFrom(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

DateTime removeTZ(DateTime dateTime) {
  return DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.millisecond);
}

DateTime addTZ(DateTime dateTime) {
  return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond);
}

DateTime safeSubtract(DateTime dateTime, Duration duration) {
  DateTime add = removeTZ(dateTime).subtract(duration);
  return addTZ(add);
}

DateTime safeAdd(DateTime dateTime, Duration duration) {
  DateTime add = removeTZ(dateTime).add(duration);
  return addTZ(add);
}
