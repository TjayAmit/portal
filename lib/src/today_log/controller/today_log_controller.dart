import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';
import 'package:zcmc_portal/src/today_log/controller/biometric_state.dart';
import 'package:zcmc_portal/src/today_log/controller/today_log_state.dart';
import 'package:zcmc_portal/src/today_log/model/today_log_model.dart';
import 'package:zcmc_portal/src/today_log/provider/today_log_provider.dart';

class TodayLogController extends StateNotifier<BiometricState> {
  final Ref ref;
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableTypes = [];

  TodayLogController(this.ref)
      : super(BiometricState(
          canAuth: false,
          canAuthWithBio: false,
          isAuthenticated: false,
          message: "Initializing biometric check...",
        )) {
    _initializeBiometric();
  }

  // --- BIOMETRIC INITIALIZATION ---
  Future<void> _initializeBiometric() async {
    try {
      final canBio = await auth.canCheckBiometrics;
      final canAuthDevice = await auth.isDeviceSupported();

      if (!canBio) {
        state = state.copyWith(
          canAuthWithBio: false,
          message: "Biometric not available or not enrolled.",
        );
        return;
      }

      availableTypes = await auth.getAvailableBiometrics();

      if (availableTypes.contains(BiometricType.face)) {
        state = state.copyWith(
          canAuth: canAuthDevice,
          canAuthWithBio: true,
          message: "✅ Face authentication available!",
        );
      } else if (availableTypes.contains(BiometricType.fingerprint)) {
        state = state.copyWith(
          canAuth: canAuthDevice,
          canAuthWithBio: true,
          message: "✅ Fingerprint authentication available!",
        );
      } else {
        state = state.copyWith(
          canAuth: canAuthDevice,
          canAuthWithBio: false,
          message: "⚠️ No supported biometric type found!",
        );
      }
    } catch (e) {
      state = state.copyWith(message: "Error initializing biometrics: $e");
    }
  }

  // --- BIOMETRIC AUTHENTICATION + ATTENDANCE ---
  Future<void> authenticateAndRegisterAttendance() async {
    try {
      final isAuthenticated = await auth.authenticate(
        localizedReason: availableTypes.contains(BiometricType.face)
            ? 'Please scan your face to register your attendance'
            : 'Please scan your fingerprint to register your attendance',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (isAuthenticated) {
        state = state.copyWith(
          isAuthenticated: true,
          message: availableTypes.contains(BiometricType.face)
              ? "✅ Face authenticated!"
              : "✅ Fingerprint authenticated!",
        );

        await postTodayLog();

        // Reset after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          state = state.copyWith(
            isAuthenticated: false,
            message: "Ready for next scan",
          );
        });
      } else {
        state = state.copyWith(
          isAuthenticated: false,
          message: "❌ Authentication failed or canceled.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        message: "Error during authentication: $e",
      );
    }
  }

  // --- GET TODAY LOG ---
  Future<void> getTodayLog() async {
    ref.read(todayLogStateProvider.notifier).state = TodayLogState.loading();
    try {
      final token = ref.read(userProvider)!.token!;
      final dtr = await ref.read(todayLogServiceProvider).getTodayLog(token);
      ref.read(todayLogStateProvider.notifier).state =
          TodayLogState.success(dtr ?? TodayLogModel());
      ref.read(todayLogProvider.notifier).state = dtr;
    } catch (e) {
      ref.read(todayLogStateProvider.notifier).state =
          TodayLogState.error(e.toString());
    }
  }

  Future<void> postTodayLog() async {
    ref.read(todayLogStateProvider.notifier).state = TodayLogState.loading();
    
    try {
      final token = ref.read(userProvider)!.token!;
      final dtr = await ref.read(todayLogServiceProvider).postTodayLog(token);

      if (dtr != null) {
        ref.read(todayLogProvider.notifier).state = dtr;
        ref
            .read(todayLogStateProvider.notifier)
            .state = TodayLogState.success(dtr);
      }
    } catch (e) {
      ref.read(todayLogStateProvider.notifier).state =
          TodayLogState.error(e.toString());
    }
  }
}
