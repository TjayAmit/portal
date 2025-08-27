import 'package:zcmc_portal/src/daily_time_record/model/dtr_model.dart';

sealed class DTRState {
  const DTRState();
  
  factory DTRState.loading() => DTRStateLoading();
  factory DTRState.initial() => DTRStateInitial();
  factory DTRState.success(List<DTRModel> dtr) => DTRStateSuccess(dtr);
  factory DTRState.error(String message) => DTRStateError(message);
}

class DTRStateInitial extends DTRState {
  const DTRStateInitial();
}

class DTRStateLoading extends DTRState {
  const DTRStateLoading();
}

class DTRStateSuccess extends DTRState {
  final List<DTRModel> dtr;
  const DTRStateSuccess(this.dtr);
}

class DTRStateError extends DTRState {
  final String message;
  const DTRStateError(this.message);
}