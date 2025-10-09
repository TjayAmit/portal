
import 'package:flutter/foundation.dart';

class LeaveState {
  final Map<String, double> leaveBalances;
  final bool isLoading;
  final String? error;

  const LeaveState({
    required this.leaveBalances,
    this.isLoading = false,
    this.error,
  });

  LeaveState copyWith({
    Map<String, double>? leaveBalances,
    bool? isLoading,
    String? error,
  }) {
    return LeaveState(
      leaveBalances: leaveBalances ?? this.leaveBalances,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is LeaveState &&
        mapEquals(other.leaveBalances, leaveBalances) &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(leaveBalances, isLoading, error);
}