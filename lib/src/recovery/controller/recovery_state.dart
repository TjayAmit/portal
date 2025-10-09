// lib/src/authentication/recovery_state.dart
class RecoveryState {
  final bool isLoading;
  final bool emailSent;
  final String? errorMessage;

  const RecoveryState({
    this.isLoading = false,
    this.emailSent = false,
    this.errorMessage,
  });

  RecoveryState copyWith({
    bool? isLoading,
    bool? emailSent,
    String? errorMessage,
  }) {
    return RecoveryState(
      isLoading: isLoading ?? this.isLoading,
      emailSent: emailSent ?? this.emailSent,
      errorMessage: errorMessage,
    );
  }
}
