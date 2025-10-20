import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/core/utils/device_authorization_pin_utils.dart';
import 'package:zcmc_portal/src/authentication/controller/auth_state.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';
import 'package:zcmc_portal/src/geofence/provider/geofence_provider.dart';
import 'package:zcmc_portal/core/utils/device_utils.dart';

class AuthController{
  final Ref ref;

  AuthController(this.ref);
  
  Future<void> login(String username, String password) async {
    ref.read(authStateProvider.notifier).state = AuthState.loading();
    final deviceId = await DeviceUtils.getDeviceUUID();

    try {
      final user = await ref.read(authServiceProvider).login(username, password, deviceId);


      if(user == null){
        ref.read(authStateProvider.notifier).state = AuthState.unauthenticated();
        return;
      }

      ref.read(authStateProvider.notifier).state = AuthState.authenticated(user);
      ref.read(userProvider.notifier).state = user;
      await ref.read(geofenceControllerProvider.notifier).startMonitoring(ref);
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
      ref.read(geofenceControllerProvider.notifier).dispose();
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
    }
  }

  Future<bool> verifyAuthorizationPin(  String pin) async {
    final storedPin = await DeviceAuthorizationPinUtils.getAuthorizationPin();
    
    return pin == storedPin;
  }
}