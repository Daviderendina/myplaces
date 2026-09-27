import 'package:flutter/foundation.dart';

enum LogLevel { info, debug, warn, error }

class AppLogger {
  static void _log(
    Type type,
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final time = DateTime.now().toIso8601String();
    final prefix = '[$time][${type.toString()}]][${level.name.toUpperCase()}]';
    debugPrint('$prefix $message');

    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
  }

  static void info(String message, Type type) => _log(type, LogLevel.info, message);

  static void debug(String message, Type type) => _log(type, LogLevel.debug, message);

  static void warn(String message, Type type) => _log(type, LogLevel.warn, message);

  static void error(String message, Type type, {Object? error, StackTrace? stackTrace}) =>
      _log(type, LogLevel.error, message, error: error, stackTrace: stackTrace);
}
