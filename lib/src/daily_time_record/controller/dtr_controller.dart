
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';
import 'package:zcmc_portal/src/daily_time_record/controller/dtr_state.dart';
import 'package:zcmc_portal/src/daily_time_record/providers/dtr_provider.dart';

class DTRController {
  final Ref ref;

  DTRController(this.ref);

  Future<void> getDTR() async {
    ref.read(dtrStateProvider.notifier).state = DTRState.loading();
    try {
      final dtr = await ref.read(dtrServiceProvider).getDTR(ref.read(userProvider)!.token!);
      ref.read(dtrStateProvider.notifier).state = DTRState.success(dtr);
      ref.read(dtrListProvider.notifier).state = dtr;
    } catch (e) {
      print('Failed to fetch DTR: ${e.toString()}');
      ref.read(dtrStateProvider.notifier).state = DTRState.error(e.toString());
    }
  }
}