import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/leave_applications/controller/leave_controller.dart';
import 'package:zcmc_portal/src/leave_applications/controller/leave_state.dart';

final leaveControllerProvider = StateNotifierProvider.autoDispose<LeaveController, LeaveState>(
  (ref) => LeaveController(),
);
