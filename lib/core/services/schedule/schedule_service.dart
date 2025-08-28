

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:zcmc_portal/src/schedule/model/schedule_model.dart';

class ScheduleService {
  final http.Client client;

  ScheduleService({http.Client? client}) : client = client ?? http.Client();

  Future<List<ScheduleModel>> getSchedule(String token) async{
    try{
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.scheduleEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Schedule failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);

      if(responseData['data'] != null){
        final scheduleData = responseData['data'];
        return List<ScheduleModel>.from(scheduleData.map((x) => ScheduleModel.fromJson(x)));
      }
    }catch(e){
      throw Exception('Schedule failed: ${e.toString()}');
    }

    return [];
  }    
}
