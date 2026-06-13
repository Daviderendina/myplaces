import 'package:shared_preferences/shared_preferences.dart';

import '../config/settings_keys.dart';

class SettingsService {
  final SharedPreferencesWithCache _prefs;

  SettingsService(this._prefs);

  Future<void> setValue(SettingsKeys key, Object? value) async {
    assert(
      value == null || value.runtimeType == key.type,
      'Tipo errato per ${key.name}: atteso ${key.type}, ricevuto ${value.runtimeType}',
    );

    final keyStr = key.name;

    if (value == null) {
      await _prefs.remove(keyStr);
    } else if (key.type == bool) {
      await _prefs.setBool(keyStr, value as bool);
    } else if (key.type == int) {
      await _prefs.setInt(keyStr, value as int);
    } else if (key.type == double) {
      await _prefs.setDouble(keyStr, value as double);
    } else if (key.type == String) {
      await _prefs.setString(keyStr, value as String);
    } else if (key.type == List<String>) {
      await _prefs.setStringList(keyStr, value as List<String>);
    } else {
      throw ArgumentError('Tipo non supportato: ${key.type}');
    }
  }

  Object? getValue(SettingsKeys key) {
    // ← sincrono
    final keyStr = key.name;

    if (key.type == bool) return _prefs.getBool(keyStr);
    if (key.type == int) return _prefs.getInt(keyStr);
    if (key.type == double) return _prefs.getDouble(keyStr);
    if (key.type == String) return _prefs.getString(keyStr);
    if (key.type == List<String>) return _prefs.getStringList(keyStr);

    throw ArgumentError('Tipo non supportato: ${key.type}');
  }
}
