extension MapGetOrDefault on Map<String, dynamic> {
  T getOrDefault<T>(String key, T defaultValue) {
    final value = this[key];
    if (value == null) return defaultValue;
    return value is T ? value : defaultValue;
  }
}
