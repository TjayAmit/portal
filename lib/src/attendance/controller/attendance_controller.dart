import 'package:local_auth/local_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'attendance_state.dart';

class AttendanceController extends StateNotifier<AttendanceState> {
  AttendanceController() : super(AttendanceState(
    canAuth: false,
    canAuthWithBio: false,
    isAuthenticated: false,
    message: "Initializing biometric check...",
  )) {
    _initialize();
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _initialize() async {
    try {
      final canBio = await auth.canCheckBiometrics;
      final canAuthDevice = await auth.isDeviceSupported();

      state = state.copyWith(
        canAuth: canAuthDevice,
        canAuthWithBio: canBio,
        message: canBio
            ? "Biometric authentication is available!"
            : "Biometric not available or not enrolled.",
      );
    } catch (e) {
      state = state.copyWith(message: "Error initializing biometrics: $e");
    }
  }

  Future<void> authenticateAndRegisterAttendance() async {
    try {
      final isAuthenticated = await auth.authenticate(
        localizedReason: 'Please scan to register your attendance',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (isAuthenticated) {
        // TODO: Trigger your backend call here
        // Example:
        // await AttendanceService().registerAttendance(userId);

        state = state.copyWith(
          isAuthenticated: true,
          message: "✅ Attendance registered successfully!",
        );
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
  
  // Future<void> authenticateAndRegisterAttendance() async {
  //   try {
  //     final didAuthenticate = await auth.authenticate(
  //       localizedReason: 'Scan your fingerprint to record attendance',
  //       options: const AuthenticationOptions(
  //         biometricOnly: true,
  //         stickyAuth: true,
  //         useErrorDialogs: true,
  //       ),
  //     );

  //     if (didAuthenticate) {
  //       // ✅ Auth success
  //       // 👉 Now send API call to Laravel backend
  //       await registerAttendanceToServer();

  //       state = state.copyWith(
  //         isAuthenticated: true,
  //         message: "✅ Attendance recorded successfully!",
  //       );
  //     } else {
  //       state = state.copyWith(
  //         message: "❌ Fingerprint scan failed or canceled.",
  //       );
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //       message: "Error during fingerprint authentication: $e",
  //     );
  //   }
  // }
}