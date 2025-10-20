

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceAuthorizationPinUtils {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static const _key = "authorization_pin";

  static Future<bool> setAuthorizationPin(String authorizationPin) async {
    try {
      await _storage.write(key: _key, value: authorizationPin);
      
      return true;
    } catch(e) {
      return false;
    }
  }

  /// Get device UUID, generate and store if not exists
  static Future<String> getAuthorizationPin() async {
    var authorizationPin = await _storage.read(key: _key);

    return authorizationPin ?? '';
  }
}