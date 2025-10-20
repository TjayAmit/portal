class PersonalInformationModel {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? suffix;
  final String sex;
  final DateTime birthDate;
  final String placeOfBirth;
  final String civilStatus;
  final String bloodType;
  final int height;
  final int weight;
  final String? religion;
  final String citizenship;

  PersonalInformationModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.suffix,
    required this.sex,
    required this.birthDate,
    required this.placeOfBirth,
    required this.civilStatus,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.religion,
    required this.citizenship,
  });

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    return PersonalInformationModel(
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      suffix: json['name_extension'],
      sex: json['sex'],
      birthDate: DateTime.parse(json['date_of_birth']),
      placeOfBirth: json['place_of_birth'],
      civilStatus: json['civil_status'],
      bloodType: json['blood_type'],
      height: json['height'],
      weight: json['weight'],
      religion: json['religion'],
      citizenship: json['citizenship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'suffix': suffix,
      'sex': sex,
      'birthDate': birthDate.toIso8601String(),
      'placeOfBirth': placeOfBirth,
      'civilStatus': civilStatus,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'religion': religion,
      'citizenship': citizenship,
    };
  }

  factory PersonalInformationModel.fromMap(Map<String, dynamic> map) {
    return PersonalInformationModel(
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      suffix: map['suffix'],
      sex: map['sex'],
      birthDate: DateTime.parse(map['birthDate']),
      placeOfBirth: map['placeOfBirth'],
      civilStatus: map['civilStatus'],
      bloodType: map['bloodType'],
      height: map['height'],
      weight: map['weight'],
      religion: map['religion'],
      citizenship: map['citizenship'],
    );
  }

  String get name => '$lastName, $firstName $middleName';
}