

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/services/auth_service.dart';
import 'package:zcmc_portal/src/authentication/controller/auth_controller.dart';
import 'package:zcmc_portal/src/authentication/controller/auth_state.dart';
import 'package:zcmc_portal/src/authentication/model/user_model.dart';


final authStateProvider = StateProvider<AuthState>((ref) => AuthStateInitial());

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider<AuthController>((ref) => AuthController(ref));

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
