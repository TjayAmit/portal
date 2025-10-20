import 'package:local_auth/local_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/attendance/provider/attendance_provider.dart';
import 'attendance_state.dart';

class AttendanceController extends StateNotifier<AttendanceState> {
  final Ref ref;

  AttendanceController(this.ref)
      : super(AttendanceState(
          canAuth: false,
          canAuthWithBio: false,
          isAuthenticated: false,
          message: "Initializing biometric check...",
        )) {
    _initialize();
  }

  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableTypes = [];

  Future<void> _initialize() async {
    try {
      final canBio = await auth.canCheckBiometrics;
      final canAuthDevice = await auth.isDeviceSupported();

      if (!canBio) {
        state = state.copyWith(
          canAuthWithBio: false,
          message: "Biometric not available or not enrolled.",
        );
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

        // await ref.read(dtrControllerProvider).postDTR();

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
}
