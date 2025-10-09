class AttendanceReport {
  final int totalDays;
  final int absences;
  final int tardinessCount;
  final int totalLateMinutes;

  AttendanceReport({
    required this.totalDays,
    required this.absences,
    required this.tardinessCount,
    required this.totalLateMinutes,
  });

  factory AttendanceReport.fromJson(Map<String, dynamic> json) {
    return AttendanceReport(
      totalDays: json['total_days'] ?? 0,
      absences: json['absences'] ?? 0,
      tardinessCount: json['tardiness_count'] ?? 0,
      totalLateMinutes: json['total_late_minutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'total_days': totalDays,
        'absences': absences,
        'tardiness_count': tardinessCount,
        'total_late_minutes': totalLateMinutes,
      };
}
