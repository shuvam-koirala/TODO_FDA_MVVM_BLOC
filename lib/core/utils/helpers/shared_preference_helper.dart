import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final SharedPreferenceHelper _instance =
      SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _instance;
  }

  SharedPreferenceHelper._internal();

  SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    return _preferences ?? await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await preferences;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await preferences;
    return prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await preferences;
    await prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final prefs = await preferences;
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveInt(String key, int value) async {
    final prefs = await preferences;
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await preferences;
    return prefs.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    final prefs = await preferences;
    await prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    final prefs = await preferences;
    return prefs.getDouble(key);
  }

  Future<void> saveListOfString(String key, List<String> value) async {
    final prefs = await preferences;
    await prefs.setStringList(key, value);
  }

  Future<List<String>> getListOfString(String key) async {
    final prefs = await preferences;
    return prefs.getStringList(key) ?? <String>[];
  }
}
