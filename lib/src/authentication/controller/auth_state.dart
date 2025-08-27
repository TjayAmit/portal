import '../model/user_model.dart';

sealed class AuthState {
  const AuthState();

  factory AuthState.loading() => AuthStateLoading();
  factory AuthState.initial() => AuthStateInitial();
  factory AuthState.authenticated(UserModel user) => AuthStateAuthenticated(user);
  factory AuthState.unauthenticated() => AuthStateUnauthenticated();
  factory AuthState.error(String message) => AuthStateError(message);
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateAuthenticated extends AuthState {
  final UserModel user;
  const AuthStateAuthenticated(this.user);
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

class AuthStateError extends AuthState {
  final String message;
  const AuthStateError(this.message);
}

