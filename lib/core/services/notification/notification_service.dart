import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:zcmc_portal/src/notifications/model/notification.dart';

class NotificationService {
  final http.Client client;

  NotificationService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Notification>> getNotification(String token) async{
    try{
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.notificationEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Notification failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);

      if(responseData['data'] != null){
        final notificationData = responseData['data'];
        return List<Notification>.from(notificationData.map((x) => Notification.fromJson(x)));
      }
    }catch(e){
      throw Exception('Notification failed: ${e.toString()}');
    }

    return [];
  }    
}
