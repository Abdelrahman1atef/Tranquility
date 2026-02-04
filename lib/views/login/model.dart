import 'package:dio/dio.dart';

class LoginRequest {
  final String email;
  final String password;
  final String deviceToken;
  final String deviceType;

  LoginRequest({
    required this.email,
    required this.password,
    required this.deviceToken,
    required this.deviceType,
  });

  FormData toFormData() {
    return FormData.fromMap({
      "Email": email,
      "Password": password,
      "DeviceToken": deviceToken,
      "DeviceType": deviceType,
    });
  }
}

class LoginResponse {
  late final Data data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late final String token;
  late final int id;
  late final String email;
  late final String name;
  late final String imageUrl;
  late final int age;
  late final String gender;
  late final bool isVerified;
  late final bool isEasyLoginEnabled;

  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.gender,
    required this.isVerified,
    required this.isEasyLoginEnabled,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    age = json['age'];
    gender = json['gender'];
    isVerified = json['isVerified'];
    isEasyLoginEnabled = json['isEasyLoginEnabled'];
  }
}
