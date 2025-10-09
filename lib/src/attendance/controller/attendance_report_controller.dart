import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_report_state.dart';
import 'package:zcmc_portal/src/attendance/model/attendance_report_model.dart';

final attendanceReportControllerProvider =
    StateNotifierProvider<AttendanceReportController, AttendanceReportState>(
  (ref) => AttendanceReportController(),
);

class AttendanceReportController extends StateNotifier<AttendanceReportState> {
  AttendanceReportController() : super(AttendanceReportState.initial());

  Future<void> loadReport({DateTime? month}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // simulate delay / dummy data
      await Future.delayed(const Duration(seconds: 1));

      // dummy data
      final dummyReport = AttendanceReport(
        totalDays: 22,
        absences: 2,
        tardinessCount: 4,
        totalLateMinutes: 45,
      );

      state = state.copyWith(
        isLoading: false,
        report: dummyReport,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load report: $e',
      );
    }
  }
}
