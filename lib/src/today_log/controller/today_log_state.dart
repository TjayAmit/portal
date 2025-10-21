import 'package:zcmc_portal/src/today_log/model/today_log_model.dart';  

sealed class TodayLogState {
  const TodayLogState();
  
  factory TodayLogState.loading() => TodayLogStateLoading();
  factory TodayLogState.initial() => TodayLogStateInitial();
  factory TodayLogState.success(TodayLogModel dtr) => TodayLogStateSuccess(dtr);
  factory TodayLogState.error(String message) => TodayLogStateError(message);
}

class TodayLogStateInitial extends TodayLogState {
  const TodayLogStateInitial();
}

class TodayLogStateLoading extends TodayLogState {
  const TodayLogStateLoading();
}

class TodayLogStateSuccess extends TodayLogState {
  final TodayLogModel dtr;
  const TodayLogStateSuccess(this.dtr);
}

class TodayLogStateError extends TodayLogState {
  final String message;
  const TodayLogStateError(this.message);
}