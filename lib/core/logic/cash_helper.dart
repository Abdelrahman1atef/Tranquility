import 'package:shared_preferences/shared_preferences.dart';
import 'package:tranquility/views/login/model.dart';

class CashHelper {
  static late final SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<void> setData(String key, dynamic value) async {
    if (value is int) {
      await _pref.setInt(key, value);
    } else if (value is String) {
      await _pref.setString(key, value);
    } else if (value is bool) {
      await _pref.setBool(key, value);
    } else if (value is double) {
      await _pref.setDouble(key, value);
    }
  }

  static Future<void> setFirstTime() async {
    await _pref.setBool("isFirstTime", false);
  }

  static bool? getFirstTime() {
    return _pref.getBool("isFirstTime");
  }

  static Future<void> setFcmToken(String token) async {
    await _pref.setString("fcmToken", token);
  }

  static String getFcmToken() {
    return _pref.getString("fcmToken") ?? "";
  }

  static Future<void> setToken(String? token) async {
    await _pref.setString("token", token??"");
  }

  static String? getToken() {
    return _pref.getString("token");
  }

  static Future<void> setEasyLoginEnabled(bool value) async {
    await _pref.setBool("isEasyLoginEnabled", value);
  }

  static Future<void> setUserDate(Data data) async {
    await _pref.setInt("id", data.id);
    await _pref.setString("name", data.name??"Gust");
    await _pref.setString("email", data.email);
    await _pref.setString("imageUrl", data.imageUrl);
    await _pref.setString("gender", data.gender);
    await _pref.setInt("age", data.age);
    await _pref.setBool("isVerified", data.isVerified??false);
    await _pref.setBool("isEasyLoginEnabled", data.isEasyLoginEnabled);
  }

  static Data? getUserData() {
    final id = _pref.getInt("id");
    final name = _pref.getString("name");
    final email = _pref.getString("email");
    final imageUrl = _pref.getString("imageUrl");
    final gender = _pref.getString("gender");
    final age = _pref.getInt("age");
    final isVerified = _pref.getBool("isVerified");
    final isEasyLoginEnabled = _pref.getBool("isEasyLoginEnabled");

    if (id == null || name == null || email == null) {
      return null;
    }

    return Data(
      token: getToken() ?? "",
      id: id,
      name: name,
      email: email,
      imageUrl: imageUrl ?? '',
      gender: gender ?? '',
      age: age ?? 0,
      isVerified: isVerified ?? false,
      isEasyLoginEnabled: isEasyLoginEnabled ?? false,
    );
  }

  static Future<void> removeUserData() async {
    await _pref.remove("token");
    await _pref.remove("id");
    await _pref.remove("name");
    await _pref.remove("email");
    await _pref.remove("imageUrl");
    await _pref.remove("gender");
    await _pref.remove("age");
    await _pref.remove("isVerified");
    await _pref.remove("isEasyLoginEnabled");
  }
}
