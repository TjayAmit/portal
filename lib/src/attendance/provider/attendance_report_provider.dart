// Dummy provider (later replace with backend data)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/model/attendance_report_model.dart';

final attendanceReportProvider = FutureProvider<AttendanceReport>((ref) async {
  await Future.delayed(const Duration(seconds: 1)); // simulate API delay
  return AttendanceReport(
    totalDays: 22,
    absences: 2,
    tardinessCount: 4,
    totalLateMinutes: 45,
  );
});