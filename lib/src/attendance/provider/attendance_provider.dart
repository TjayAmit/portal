import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_controller.dart';
import 'package:zcmc_portal/src/attendance/controller/attendance_state.dart';

final attendanceControllerProvider =
    StateNotifierProvider<AttendanceController, AttendanceState>(
  (ref) => AttendanceController(),
);
