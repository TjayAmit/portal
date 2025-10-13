import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/notifications/provider/notification.dart';
import 'package:zcmc_portal/src/notifications/controller/notification_state.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class NotificationController {
  final Ref ref;

  NotificationController(this.ref);

  Future<void> getNotification() async {
    ref.read(notificationStateProvider.notifier).state = NotificationState.loading();
    try {
      final notification = await ref.read(notificationServiceProvider).getNotification(ref.read(userProvider)!.token!);
      ref.read(notificationStateProvider.notifier).state = NotificationState.success(notification);
      ref.read(notificationListProvider.notifier).state = notification;
    } catch (e) {
      print('Failed to fetch Notification: ${e.toString()}');
      ref.read(notificationStateProvider.notifier).state = NotificationState.error(e.toString());
    }
  } 
}