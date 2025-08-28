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
