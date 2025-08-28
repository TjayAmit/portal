

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/services/schedule/schedule_service.dart';
import 'package:zcmc_portal/src/schedule/controller/schedule_controller.dart';
import 'package:zcmc_portal/src/schedule/controller/schedule_state.dart';
import 'package:zcmc_portal/src/schedule/model/schedule_model.dart';

final scheduleServiceProvider = Provider<ScheduleService>((ref) {
  return ScheduleService();
});

final scheduleControllerProvider = Provider<ScheduleController>((ref) => ScheduleController(ref));

final scheduleStateProvider = StateProvider<ScheduleState>((ref) => ScheduleInitial());

final scheduleListProvider = StateProvider<List<ScheduleModel>>((ref) => []);