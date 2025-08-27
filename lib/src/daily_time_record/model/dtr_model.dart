
class DTRModel {
  final int id;
  final int biometricId;
  final String? timeIn;
  final String? breakOut;
  final String? breakIn;
  final String? timeOut;
  final String? overTime;

  DTRModel({
    required this.id,
    required this.biometricId,
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
      timeIn: json['first_in'],
      breakOut: json['first_out'],
      breakIn: json['second_in'],
      timeOut: json['second_out'],
      overTime: json['overtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biometric_id': biometricId,
      'time_in': timeIn,
      'break_out': breakOut,
      'break_in': breakIn,
      'time_out': timeOut,
      'over_time': overTime,
    };
  }
}