import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_controller.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_state.dart';
import 'package:zcmc_portal/src/daily_time_record/controller/dtr_controller.dart';

final attendanceControllerProvider =
    StateNotifierProvider<AttendanceController, AttendanceState>(
  (ref) => AttendanceController(ref),
);

final dtrControllerProvider = Provider<DTRController>(
  (ref) => DTRController(ref),
);
