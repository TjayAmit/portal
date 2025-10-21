class ApiConstants {
  static const String baseUrl = 'http://192.168.36.150:81/api';
  static const String loginEndpoint = '/auth/sign-in';
  static const String refreshSessionEndpoint = '/auth/refresh-session';
  static const String logoutEndpoint = '/v2/sign-out';
  static const String dtrEndpoint = '/v2/daily-time-records';
  static const String scheduleEndpoint = '/v2/schedules';
  static const String notificationEndpoint = '/notifications';
  static const String dtrEndPoint  = '/v2/daily-time-records';
  static const String todayLogEndPoint = '/v2/today-logs';
  
  // GeoFence API
  static const String geoFenceUrl = 'https://geofenceapi.zcmc.online/api';
  static const String checkLocation = '/fences/check';
}