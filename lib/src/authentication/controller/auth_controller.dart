import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/controller/auth_state.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class AuthController{
  final Ref ref;

  AuthController(this.ref);
  
  Future<void> login(String username, String password) async {
    ref.read(authStateProvider.notifier).state = AuthState.loading();
    try {
      final user = await ref.read(authServiceProvider).login(username, password);


      if(user == null){
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated();
        return;
      }

      ref.read(authStateProvider.notifier).state = AuthState.authenticated(user);
      ref.read(userProvider.notifier).state = user;
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    ref.read(authStateProvider.notifier).state = AuthState.loading();
    try {
      await ref.read(authServiceProvider).logout(ref.read(userProvider)!.token!);
      ref.read(authStateProvider.notifier).state = AuthState.unauthenticated();
      ref.read(userProvider.notifier).state = null;
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
    }
  }
}