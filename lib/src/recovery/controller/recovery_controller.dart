// lib/src/authentication/recovery_controller.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'recovery_state.dart';

final recoveryControllerProvider =
    StateNotifierProvider<RecoveryController, RecoveryState>(
  (ref) => RecoveryController(),
);

class RecoveryController extends StateNotifier<RecoveryState> {
  RecoveryController() : super(const RecoveryState());

  // TODO: set your real base URL
  static const String baseUrl = 'https://your-api.example.com';

  /// Sends password recovery email.
  /// Returns true if request succeeded (email sent).
  Future<bool> sendRecoveryEmail(String email) async {
    // basic validation
    if (!_isValidEmail(email)) {
      state = state.copyWith(errorMessage: 'Please enter a valid email address.');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, emailSent: false);

    try {
      final uri = Uri.parse('$baseUrl/api/auth/password/forgot');
      final resp = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (resp.statusCode == 200 || resp.statusCode == 202) {
        // assume backend sent recovery email
        state = state.copyWith(isLoading: false, emailSent: true);
        return true;
      }

      // try to parse error message from backend
      String message = 'Failed to send recovery email.';
      try {
        final data = jsonDecode(resp.body);
        if (data is Map && data['message'] != null) message = data['message'];
        else if (data is Map && data['error'] != null) message = data['error'];
      } catch (_) {}

      state = state.copyWith(isLoading: false, errorMessage: message);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Network error. Please check your connection.',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  // Simple email regex validation
  bool _isValidEmail(String email) {
    final regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(email);
  }

  /// Verify OTP
  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(seconds: 2)); // simulate network delay

    // Fake OTP check
    if (otp == '123456') {
      state = state.copyWith(isLoading: false, otpVerified: true);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid or expired OTP code',
      );
      return false;
    }
  }

  /// Resend OTP
  Future<void> resendOtp() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(const Duration(seconds: 2));

    // Fake resend success
    state = state.copyWith(isLoading: false);
  }
}
