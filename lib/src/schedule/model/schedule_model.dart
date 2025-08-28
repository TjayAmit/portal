class ScheduleModel {
  final int id;
  final String date;
  final String time;
  final String color;

  ScheduleModel({
    required this.id,
    required this.date,
    required this.time,
    required this.color,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'color': color,
    };
  }
}