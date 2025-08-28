import 'package:zcmc_portal/src/authentication/model/contact_model.dart';
import 'package:zcmc_portal/src/authentication/model/designation_model.dart';
import 'package:zcmc_portal/src/authentication/model/personal_information_model.dart';

class UserModel{
  final int id;
  final String employeeId;
  final String name;
  final PersonalInformationModel personalInformation;
  final ContactModel contact; 
  final DesignationModel designation;
  late String? token;

  UserModel({
    required this.id, 
    required this.employeeId, 
    required this.name, 
    required this.personalInformation,
    required this.contact,
    required this.designation,  
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      employeeId: json['employee_id'],  
      name: json['name'],
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
      'personal_information': personalInformation.toJson(),
      'contact': contact.toJson(),
      'designation': designation.toJson(),
      'token': token,
    };
  }

  setToken(String token) => this.token = token;
}