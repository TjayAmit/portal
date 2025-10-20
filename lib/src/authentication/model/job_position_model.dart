class JobPositionModel {
  final String name;
  final String code;
  final int salaryGrade;
  final int step;
  final int salaryAmount;

  JobPositionModel({
    required this.name,
    required this.code,
    required this.salaryGrade,
    required this.step,
    required this.salaryAmount,
  });

  factory JobPositionModel.fromJson(Map<String, dynamic> json) {
    return JobPositionModel(
      name: json['name'],
      code: json['code'],
      salaryGrade: json['salary_grade'],
      step: json['step'],
      salaryAmount: json['salary_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'salary_grade': salaryGrade,
      'step': step,
      'salary_amount': salaryAmount,
    };
  }

  factory JobPositionModel.fromMap(Map<String, dynamic> map) {
    return JobPositionModel(
      name: map['name'],
      code: map['code'],
      salaryGrade: map['salary_grade'],
      step: map['step'],
      salaryAmount: map['salary_amount'],
    );
  }
}