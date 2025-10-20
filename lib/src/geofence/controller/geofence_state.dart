import 'package:zcmc_portal/src/geofence/model/geofence_model.dart';

sealed class GeofenceState{
  const GeofenceState();

  factory GeofenceState.loading() => GeofenceStateLoading();
  factory GeofenceState.initial() => GeofenceStateInitial();
  factory GeofenceState.success(GeofenceModel geofenceModel) => GeofenceStateSuccess(geofenceModel);
  factory GeofenceState.error(String message) => GeofenceStateError(message);
}

class GeofenceStateInitial extends GeofenceState{
  const GeofenceStateInitial();
}

class GeofenceStateLoading extends GeofenceState{
  const GeofenceStateLoading();
}

class GeofenceStateSuccess extends GeofenceState{
  final GeofenceModel geofenceModel;
  const GeofenceStateSuccess(this.geofenceModel);
}

class GeofenceStateError extends GeofenceState{
  final String message;
  const GeofenceStateError(this.message);
}