import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zcmc_portal/src/geofence/controller/geofence_state.dart';
import 'package:zcmc_portal/core/services/geofence/geofence_service.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class GeofenceController extends StateNotifier<GeofenceState> {
  GeofenceController() : super(const GeofenceStateInitial());

  Position? _lastPosition;
  Timer? _timer;

  Future<void> startMonitoring(Ref ref) async {
    await _checkAndUpdateLocation(ref);
    _startPeriodicCheck(ref);
  }

  void _startPeriodicCheck(Ref ref) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 15), (_) async {
        await _checkAndUpdateLocation(ref);
    });
  }

  Future<void> _checkAndUpdateLocation(Ref ref) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      if (_lastPosition != null) {
        final distance = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        if (distance < 5) return;
      }

      _lastPosition = position;
      await _validateFence(ref, position);
    } catch (e) {
      state = GeofenceStateError(e.toString());
    }
  }

  Future<void> _validateFence(Ref ref, Position position) async {
    state = const GeofenceStateLoading();

    final token = ref.read(userProvider)?.token;
    if (token == null) throw Exception("User token not found.");

    final body = {
      "lat": position.latitude,
      "lng": position.longitude,
      "location": "zcmc"
    };

    final response = await GeofenceService().checkLocation(token, body);
    state = GeofenceStateSuccess(response);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
