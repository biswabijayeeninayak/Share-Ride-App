// To parse this JSON data, do
//
//     final SignUpBody = SignUpBodyFromJson(jsonString);

import 'dart:convert';

SignUpBody SignUpBodyFromJson(String str) =>
    SignUpBody.fromJson(json.decode(str));

String SignUpBodyToJson(SignUpBody data) => json.encode(data.toJson());

class SignUpBody {
  String userType;
  String userName;
  String email;
  String phone;

  SignUpBody({
    required this.userType,
    required this.userName,
    required this.email,
    required this.phone,
  });

  factory SignUpBody.fromJson(Map<String, dynamic> json) => SignUpBody(
        userType: json["user_type"],
        userName: json["user_name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "user_type": "rider",
        "user_name": userName,
        "email": email,
        "phone": phone,
      };
}
