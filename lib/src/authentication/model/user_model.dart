class UserModel{
  final int id;
  final String employeeId;
  final String name;
  final String token;

  UserModel({required this.id, required this.employeeId, required this.name, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      employeeId: json['employee_id'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'name': name,
      'token': token,
    };
  }
}