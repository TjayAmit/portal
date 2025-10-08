
class AttendanceState {
  final bool canAuth;
  final bool canAuthWithBio;
  final bool isAuthenticated;
  final String message;

  AttendanceState({
    required this.canAuth,
    required this.canAuthWithBio,
    required this.isAuthenticated,
    required this.message,
  });

  AttendanceState copyWith({
    bool? canAuth,
    bool? canAuthWithBio,
    bool? isAuthenticated,
    String? message,
  }) {
    return AttendanceState(
      canAuth: canAuth ?? this.canAuth,
      canAuthWithBio: canAuthWithBio ?? this.canAuthWithBio,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      message: message ?? this.message,
    );
  }
}