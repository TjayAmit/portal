class AreaAssignedModel {
  final String name;
  final String code;

  AreaAssignedModel({
    required this.name,
    required this.code,
  });

  factory AreaAssignedModel.fromJson(Map<String, dynamic> json) {
    return AreaAssignedModel(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }

  factory AreaAssignedModel.fromMap(Map<String, dynamic> map) {
    return AreaAssignedModel(
      name: map['name'],
      code: map['code'],
    );
  }
}