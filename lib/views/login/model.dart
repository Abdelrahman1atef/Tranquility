import 'package:dio/dio.dart';

class LoginRequest {
 late final String email;
 late final String password;
 late final String deviceToken;
 late final String deviceType;

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
   final String? token;
   final int id;
   final String email;
   final String? name;
   final String imageUrl;
   final int age;
   final String gender;
   final bool? isVerified;
   final bool isEasyLoginEnabled;


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

  factory  Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      age: json['age'],
      gender: json['gender'],
      isVerified: json['isVerified'],
      isEasyLoginEnabled: json['isEasyLoginEnabled'],
    );
  }
}
