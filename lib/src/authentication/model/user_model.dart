import 'dart:convert';

import 'package:zcmc_portal/src/authentication/model/contact_model.dart';
import 'package:zcmc_portal/src/authentication/model/designation_model.dart';
import 'package:zcmc_portal/src/authentication/model/personal_information_model.dart';

class UserModel{
  final int id;
  final String employeeId;
  final String name;
  final String authorizationPin;
  final PersonalInformationModel personalInformation;
  final ContactModel contact; 
  final DesignationModel designation;
  late String? token;

  UserModel({
    required this.id, 
    required this.employeeId, 
    required this.name, 
    required this.authorizationPin,
    required this.personalInformation,
    required this.contact,
    required this.designation,  
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      employeeId: json['employee_id'],  
      name: json['name'],
      authorizationPin: json['authorization_pin'],
      personalInformation: PersonalInformationModel.fromJson(json['personal_information']),
      contact: ContactModel.fromJson(json['contact']),
      designation: DesignationModel.fromJson(json['designation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'name': name,
      'authorization_pin': authorizationPin,
      'personal_information': personalInformation.toJson(),
      'contact': contact.toJson(),
      'designation': designation.toJson(),
      'token': token,
    };
  }

  setToken(String token) => this.token = token;
  
  factory UserModel.fromMap(Map<String, dynamic> map) {
    
    final personalInfo = jsonDecode(map['personal_information']);
    final contactInfo = jsonDecode(map['contact']);
    final designationInfo = jsonDecode(map['designation']);

    return UserModel(
      id: map['id'],
      employeeId: map['employee_id'],
      name: map['name'],
      authorizationPin: map['authorization_pin'],
      personalInformation: PersonalInformationModel.fromMap(personalInfo),
      contact: ContactModel.fromMap(
        contactInfo,
      ),
      designation: DesignationModel.fromMap(designationInfo),
    );
  }
}