import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/recovery/controller/recovery_controller.dart';
import 'package:zcmc_portal/src/recovery/controller/recovery_state.dart';

final recoveryControllerProvider =
    StateNotifierProvider<RecoveryController, RecoveryState>(
  (ref) => RecoveryController(),
);