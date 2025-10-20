class ContactModel {
  final String email;
  final String phoneNumber;

  ContactModel({
    required this.phoneNumber,
    required this.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      email: json['email_address'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      email: map['email'],
      phoneNumber: map['phone_number'],
    );
  }
}