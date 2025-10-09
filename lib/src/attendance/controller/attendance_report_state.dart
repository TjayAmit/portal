import 'package:zcmc_portal/src/attendance/model/attendance_report_model.dart';

class AttendanceReportState {
  final bool isLoading;
  final AttendanceReport? report;
  final String? error;

  const AttendanceReportState({
    this.isLoading = false,
    this.report,
    this.error,
  });

  AttendanceReportState copyWith({
    bool? isLoading,
    AttendanceReport? report,
    String? error,
  }) {
    return AttendanceReportState(
      isLoading: isLoading ?? this.isLoading,
      report: report ?? this.report,
      error: error,
    );
  }

  factory AttendanceReportState.initial() => const AttendanceReportState();
}
