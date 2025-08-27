

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/services/daily_time_record/dtr_service.dart';
import 'package:zcmc_portal/src/daily_time_record/controller/dtr_state.dart';
import 'package:zcmc_portal/src/daily_time_record/controller/dtr_controller.dart';
import 'package:zcmc_portal/src/daily_time_record/model/dtr_model.dart';

final dtrStateProvider = StateProvider<DTRState>((ref) => DTRStateInitial());

final dtrServiceProvider = Provider<DTRService>((ref) {
  return DTRService();
});

final dtrControllerProvider = Provider<DTRController>((ref) => DTRController(ref));

final dtrListProvider = StateProvider<List<DTRModel>>((ref) => []);