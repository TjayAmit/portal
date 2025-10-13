import "package:zcmc_portal/src/notifications/model/notification.dart";

sealed class NotificationState {
  const NotificationState();

  factory NotificationState.loading() => NotificationStateLoading();
  factory NotificationState.initial() => NotificationStateInitial();
  factory NotificationState.success(List<Notification> notification) => NotificationStateSuccess(notification);
  factory NotificationState.error(String message) => NotificationStateError(message);
}

class NotificationStateInitial extends NotificationState {
  const NotificationStateInitial();
}

class NotificationStateLoading extends NotificationState {
  const NotificationStateLoading();
}

class NotificationStateSuccess extends NotificationState {
  final List<Notification> notification;
  const NotificationStateSuccess(this.notification);
}

class NotificationStateError extends NotificationState {
  final String message;
  const NotificationStateError(this.message);
}
