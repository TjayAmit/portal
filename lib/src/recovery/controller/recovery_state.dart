class RecoveryState {
  final bool isLoading;
  final String? errorMessage;
  final bool emailSent;
  final bool otpVerified;

  const RecoveryState({
    this.isLoading = false,
    this.errorMessage,
    this.emailSent = false,
    this.otpVerified = false,
  });

  RecoveryState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? emailSent,
    bool? otpVerified,
  }) {
    return RecoveryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      emailSent: emailSent ?? this.emailSent,
      otpVerified: otpVerified ?? this.otpVerified,
    );
  }
}