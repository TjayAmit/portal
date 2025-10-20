

import 'package:zcmc_portal/core/services/geofence/geofence_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/geofence/controller/geofence_controller.dart';
import 'package:zcmc_portal/src/geofence/controller/geofence_state.dart';

final geofenceServiceProvider = Provider<GeofenceService>((ref) {
  return GeofenceService();
});

final geofenceControllerProvider =
    StateNotifierProvider<GeofenceController, GeofenceState>(
  (ref) => GeofenceController(),
);
