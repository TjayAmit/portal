String extractTime(String time){
  return time.split(' ')[1];
}

String extractDate(String time){
  return time.split(' ')[0];
}

String convertDateToName(String date){
  DateTime dateTime = DateTime.parse(date);
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  return '${months[dateTime.month - 1]} ${dateTime.day.toString()} ${dateTime.year.toString()}';
}

String convertDateToDay(String date) {
  DateTime parsedDate = DateTime.parse(date);
  
  String dayOfWeek = _getDayOfWeek(parsedDate.weekday);
  String monthName = _getMonthName(parsedDate.month);
  int year = parsedDate.year;
  
  return '$dayOfWeek $monthName $year';
}

String _getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1: return 'Monday';
    case 2: return 'Tuesday';
    case 3: return 'Wednesday';
    case 4: return 'Thursday';
    case 5: return 'Friday';
    case 6: return 'Saturday';
    case 7: return 'Sunday';
    default: return 'Unknown';
  }
}

String _getMonthName(int month) {
  switch (month) {
    case 1: return 'January';
    case 2: return 'February';
    case 3: return 'March';
    case 4: return 'April';
    case 5: return 'May';
    case 6: return 'June';
    case 7: return 'July';
    case 8: return 'August';
    case 9: return 'September';
    case 10: return 'October';
    case 11: return 'November';
    case 12: return 'December';
    default: return 'Unknown';
  }
}