import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService extends GetxService {
  static SharedPreferences? _prefs;

  /// 🔥 Initialize (app start এ call হবে)
  Future<PrefService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// 🔹 Save String
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// 🔹 Get String
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// 🔹 Remove Key
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// 🔹 Clear All
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}