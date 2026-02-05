import 'package:dio/dio.dart';

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String age;
  final String gender;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.age,
    required this.gender,
  });

  FormData toFormData() {
    final formData = FormData();
    formData.fields.add(MapEntry("Name", name));
    formData.fields.add(MapEntry("Email", email));
    formData.fields.add(MapEntry("Password", password));
    formData.fields.add(MapEntry("ConfirmPassword", confirmPassword));
    formData.fields.add(MapEntry("Age", age));
    formData.fields.add(MapEntry("Gender", gender));
    return formData;
  }
}
