bool isSameDate(DateTime a, DateTime b) {
  return removeTimeFrom(a) == removeTimeFrom(b);
}

DateTime removeTimeFrom(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}
