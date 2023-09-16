import 'package:shared_preferences/shared_preferences.dart';

class Sharepref {
  static late SharedPreferences shared_pre;

  static init() async {
    shared_pre = await SharedPreferences.getInstance();
  }

  static Future<bool> savedata(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await shared_pre.setString(key, value);
    }
    if (value is int) {
      return await shared_pre.setInt(key, value);
    }
    if (value is bool) {
      return await shared_pre.setBool(key, value);
    }
    return await shared_pre.setDouble(key, value);
  }

  static dynamic getdata({required String key})
  {
    return shared_pre.get(key);
  }
  static Future<bool> Deletedata({required String key})
  {
      return shared_pre.remove(key);
  }
}
