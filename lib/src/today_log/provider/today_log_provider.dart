import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/services/today_logs/today_log_service.dart';
import 'package:zcmc_portal/src/today_log/controller/biometric_state.dart';
import 'package:zcmc_portal/src/today_log/controller/today_log_state.dart';
import 'package:zcmc_portal/src/today_log/controller/today_log_controller.dart';
import 'package:zcmc_portal/src/today_log/model/today_log_model.dart';

final todayLogStateProvider = StateProvider<TodayLogState>((ref) => TodayLogStateInitial());

final todayLogServiceProvider = Provider<TodayLogService>((ref) {
  return TodayLogService();
});

final todayLogControllerProvider =
    StateNotifierProvider<TodayLogController, BiometricState>((ref) {
  return TodayLogController(ref);
});

final todayLogProvider = StateProvider<TodayLogModel?>((ref) => null);