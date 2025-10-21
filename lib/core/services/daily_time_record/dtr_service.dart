import 'dart:convert';

import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:zcmc_portal/src/daily_time_record/model/dtr_model.dart';

class DTRService{
  final http.Client client;

  DTRService({http.Client? client}) : client = client ?? http.Client();

  Future<List<DTRModel>> getDTR(String token) async{
    try{
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.dtrEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('DTR failed: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      
      if(responseData['data'] != null){
        final dtrData = responseData['data'];
        return List<DTRModel>.from(dtrData.map((x) => DTRModel.fromJson(x)));
      }
    }catch(e){
      throw Exception('DTR failed: ${e.toString()}');
    }

    return [];
  }
}