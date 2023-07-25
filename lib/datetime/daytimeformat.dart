String convertDataTimeToString(DateTime dateTime) {
  // year in the format
  String year = dateTime.year.toString();

  // month in the format
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  // day in the format
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}