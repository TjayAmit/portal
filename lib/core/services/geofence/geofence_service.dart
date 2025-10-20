import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:zcmc_portal/src/geofence/model/geofence_model.dart';

class GeofenceService{
  final http.Client client;

  GeofenceService({http.Client? client}) : client = client ?? http.Client();

  Future<GeofenceModel> checkLocation(String token, Map<String, dynamic> body) async{
    try{
      final response = await client.post(
        Uri.parse(ApiConstants.geoFenceUrl + ApiConstants.checkLocation),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'x-api-key': 'API_SECRET_KEY',
        },
        body: json.encode(body),
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Check Location failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      
      return GeofenceModel.fromJson(responseData);
    }catch(e){
      throw Exception('Check Location failed: $e');
    }
  }
}