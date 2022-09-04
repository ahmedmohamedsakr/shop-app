import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/services/service_locator.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> setData({required String key, required dynamic value}) {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else {
      return sharedPreferences.setDouble(key, value);
    }
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
