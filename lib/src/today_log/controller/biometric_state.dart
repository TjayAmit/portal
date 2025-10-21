
class BiometricState {
  final bool canAuth;
  final bool canAuthWithBio;
  final bool isAuthenticated;
  final String message;

  BiometricState({
    required this.canAuth,
    required this.canAuthWithBio,
    required this.isAuthenticated,
    required this.message,
  });

  BiometricState copyWith({
    bool? canAuth,
    bool? canAuthWithBio,
    bool? isAuthenticated,
    String? message,  
  }) {
    return BiometricState(
      canAuth: canAuth ?? this.canAuth,
      canAuthWithBio: canAuthWithBio ?? this.canAuthWithBio,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      message: message ?? this.message,
    );
  }
}