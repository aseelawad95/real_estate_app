import 'package:shared_preferences/shared_preferences.dart';

/// Generic wrapper around SharedPreferences.
/// Call SharedPrefsHelper.instance.init() once in main(),
/// then use it anywhere without dealing with SharedPreferences directly.
class SharedPrefsHelper {
  SharedPrefsHelper._internal();
  static final SharedPrefsHelper instance = SharedPrefsHelper._internal();

  SharedPreferences? _prefs;
  bool _isInitialized = false;

  /// Must be called once before using any other method (e.g. in main()).
  Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  SharedPreferences get _instance {
    if (!_isInitialized || _prefs == null) {
      throw StateError(
        'SharedPrefsHelper not initialized. Call init() before using it.',
      );
    }
    return _prefs!;
  }

  // ---------------- String ----------------
  Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  String? getString(String key) => _instance.getString(key);

  // ---------------- Bool ----------------
  Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  bool? getBool(String key) => _instance.getBool(key);

  // ---------------- Int ----------------
  Future<bool> setInt(String key, int value) => _instance.setInt(key, value);

  int? getInt(String key) => _instance.getInt(key);

  // ---------------- Double ----------------
  Future<bool> setDouble(String key, double value) =>
      _instance.setDouble(key, value);

  double? getDouble(String key) => _instance.getDouble(key);

  // ---------------- List<String> ----------------
  Future<bool> setStringList(String key, List<String> value) =>
      _instance.setStringList(key, value);

  List<String>? getStringList(String key) => _instance.getStringList(key);

  // ---------------- Utilities ----------------
  bool containsKey(String key) => _instance.containsKey(key);

  Future<bool> remove(String key) => _instance.remove(key);

  Future<bool> clear() => _instance.clear();
}