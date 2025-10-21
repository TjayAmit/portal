import 'dart:convert';

import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:zcmc_portal/src/today_log/model/today_log_model.dart';

class TodayLogService{
  final http.Client client;

  TodayLogService({http.Client? client}) : client = client ?? http.Client();

  Future<TodayLogModel?> getTodayLog(String token) async{
    try{
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.todayLogEndPoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', 
        },
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Today Log failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      
      if(responseData['data'] != null){
        final log = responseData['data'];
        return TodayLogModel.fromJson(log); 
      }
    }catch(e){
      throw Exception('Today Log failed: ${e.toString()}');
    }

    return null;
  }

  Future<TodayLogModel?> postTodayLog(String token) async {
    try{
      final response = await client.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.todayLogEndPoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'time_log': DateTime.now().toIso8601String(),
        }),
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Today Log failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      
      if(responseData['data'] != null){
        final dtrData = responseData['data'];
        return TodayLogModel.fromJson(dtrData);
      }
    }catch(e){
      throw Exception('Today Log failed: ${e.toString()}');
    }

    return null;
  }
}