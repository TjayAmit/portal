import 'dart:convert';
import 'package:zcmc_portal/core/constants/api_constants.dart';
import 'package:zcmc_portal/core/database/user_db.dart';
import 'package:zcmc_portal/core/utils/device_authorization_pin_utils.dart';
import 'package:zcmc_portal/src/authentication/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService{
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  Future<UserModel?> login(String employeeId, String password, String deviceId) async {
    try{
      final response = await client.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'employee_id': employeeId, 'password': password, 'device_uuid': deviceId}),
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode == 200){
        final responseData = json.decode(response.body);
        
        if(responseData['data'] != null){
          final userData = responseData['data'];
          final user = UserModel.fromJson(userData);
          user.setToken(responseData['token']);

          await UserDatabase.instance.insertUser(user);

          if (await DeviceAuthorizationPinUtils.getAuthorizationPin() == ''){
            await DeviceAuthorizationPinUtils.setAuthorizationPin(user.authorizationPin);
          }

          return user;
        }
      }else if(response.statusCode == 401){
        throw Exception('Invalid email or password');
      }else if(response.statusCode == 400){
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Bad request');
      }else{
        throw Exception('Server error: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Invalid response format from server: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }

    return null;
  }

  Future<UserModel?> retrieveUser() async {
    final users  = await UserDatabase.instance.getAllUsers();
    
    if (users.isNotEmpty) {
      final user = users.first;

      
    final response = await client
      .get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.refreshSessionEndpoint}?employee_id=${user.employeeId}',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      )
      .timeout(const Duration(seconds: 30));

      final responseData = json.decode(response.body);

      user.setToken(responseData['token']);

      return user;
    } else {
      return null;
    }
  }

  Future<void> logout(String token) async{
    try{
      final response = await client.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.logoutEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if(response.statusCode != 200){
        throw Exception('Logout failed: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Logout failed: ${e.toString()}');
    }
  }
}