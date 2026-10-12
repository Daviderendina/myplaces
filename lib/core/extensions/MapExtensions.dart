import 'package:myplaces/logger.dart';

extension MapGetOrDefault on Map {
  T? getOrDefault<T>(String key, T? defaultValue) {
    final value = this[key];
    if (value == null) {
      AppLogger.warn('Key "$key" not found in map $this, returning default value', Map);
      return defaultValue;
    }
    return value is T ? value : defaultValue;
  }
}
