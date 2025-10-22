class TodayLogModel {
  final int id;
  final String date;
  final String timeIn;
  final String breakOut;
  final String breakIn;
  final String timeOut;

  TodayLogModel({
    this.id = 0,
    String? date,
    this.timeIn = '',
    this.breakOut = '',
    this.breakIn = '',
    this.timeOut = '',
  }) : date = date ?? DateTime.now().toIso8601String().split('T').first;

  factory TodayLogModel.fromJson(Map<String, dynamic> json) {
    return TodayLogModel(
      id: json['id'] ?? 0,
      date: json['date'],
      timeIn: json['time_in'] ?? '',
      breakOut: json['break_out'] ?? '',
      breakIn: json['break_in'] ?? '',
      timeOut: json['time_out'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'time_in': timeIn,
    'break_out': breakOut,
    'break_in': breakIn,
    'time_out': timeOut,
  };
}
