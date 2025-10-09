import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/leave_applications/controller/leave_state.dart';

class LeaveController extends StateNotifier<LeaveState> {
  LeaveController() : super(_initialState);

  static final _initialState = LeaveState(
    leaveBalances: {
      'sick_leave': 10.5,
      'vacation_leave': 15.0,
      'maternity_leave': 60.0,
      'paternity_leave': 7.0,
      'special_leave': 3.0,
    },
  );

  // Example method to update leave balances
  Future<void> fetchLeaveBalances() async {
    try {
      state = state.copyWith(isLoading: true);
      
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      state = state.copyWith(
        leaveBalances: {
          'sick_leave': 10.5,
          'vacation_leave': 15.0,
          'maternity_leave': 60.0,
          'paternity_leave': 7.0,
          'special_leave': 3.0,
        },
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      rethrow;
    }
  }
}