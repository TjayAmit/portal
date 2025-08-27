
class DTRModel {
  final int id;
  final int biometricId;
  final String? date;
  final String? timeIn;
  final String? breakOut;
  final String? breakIn;
  final String? timeOut;
  final String? overTime;

  DTRModel({
    required this.id,
    required this.biometricId,
    required this.date,
    required this.timeIn,
    required this.breakOut,
    required this.breakIn,
    required this.timeOut,
    required this.overTime,
  });

  factory DTRModel.fromJson(Map<String, dynamic> json) {
    return DTRModel(
      id: json['id'],
      biometricId: json['biometric_id'],
      date: json['date'],
      timeIn: json['time_in'],
      breakOut: json['break_out'],
      breakIn: json['break_in'],
      timeOut: json['time_out'],
      overTime: json['over_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biometric_id': biometricId,
      'date': date,
      'time_in': timeIn,
      'break_out': breakOut,
      'break_in': breakIn,
      'time_out': timeOut,
      'over_time': overTime,
    };
  }
}