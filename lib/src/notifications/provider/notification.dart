

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/services/notification/notification_service.dart';
import 'package:zcmc_portal/src/notifications/controller/notification_state.dart';
import 'package:zcmc_portal/src/notifications/controller/notification.dart';
import 'package:zcmc_portal/src/notifications/model/notification.dart';

final notificationStateProvider = StateProvider<NotificationState>((ref) => NotificationStateInitial());

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final notificationControllerProvider = Provider<NotificationController>((ref) => NotificationController(ref));

final notificationListProvider = StateProvider<List<Notification>>((ref) => []);