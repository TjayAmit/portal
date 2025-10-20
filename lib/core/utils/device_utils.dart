

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceUtils {
  static final Uuid _uuid = Uuid();
  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static const _key = "device_uuid";

  /// Get device UUID, generate and store if not exists
  static Future<String> getDeviceUUID() async {
    var deviceId = await _storage.read(key: _key);
    
    if (deviceId == null) {
      deviceId = _uuid.v4();
      await _storage.write(key: _key, value: deviceId);
    }
    return deviceId;
  }
}