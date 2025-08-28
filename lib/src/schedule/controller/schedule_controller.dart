
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/schedule/controller/schedule_state.dart';
import 'package:zcmc_portal/src/schedule/providers/schedule_provider.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class ScheduleController {
  final Ref ref;

  ScheduleController(this.ref);

  Future<void> get() async {
    ref.read(scheduleStateProvider.notifier).state = ScheduleLoading();
    try {
      final schedule = await ref.read(scheduleServiceProvider).getSchedule(ref.read(userProvider)!.token!);
      ref.read(scheduleStateProvider.notifier).state = ScheduleSuccess(schedule);
      ref.read(scheduleListProvider.notifier).state = schedule;
    } catch (e) {
      print('Failed to fetch schedule: ${e.toString()}');
      ref.read(scheduleStateProvider.notifier).state = ScheduleError(e.toString());
    }
  }
}
