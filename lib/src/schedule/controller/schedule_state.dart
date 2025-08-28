import 'package:zcmc_portal/src/schedule/model/schedule_model.dart';

sealed class ScheduleState {
  const ScheduleState();
  
  factory ScheduleState.loading() => ScheduleLoading();
  factory ScheduleState.initial() => ScheduleInitial();
  factory ScheduleState.success(List<ScheduleModel> schedules) => ScheduleSuccess(schedules);
  factory ScheduleState.error(String message) => ScheduleError(message);
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleModel> schedules;

  const ScheduleSuccess(this.schedules);
}

class ScheduleError extends ScheduleState {
  final String message;
  const ScheduleError(this.message);
}

