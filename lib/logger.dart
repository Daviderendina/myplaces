import 'package:flutter/foundation.dart';

enum LogLevel { info, debug, warn, error }

class AppLogger {
  const AppLogger();

  void _log(Type type, LogLevel level, String message, {Object? error, StackTrace? stackTrace}) {
    final time = DateTime.now().toIso8601String();
    final prefix = '[$time][${type.toString()}]][${level.name.toUpperCase()}]';
    debugPrint('$prefix $message');

    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
  }

  void info(String message, Type type) => _log(type, LogLevel.info, message);

  void debug(String message, Type type) => _log(type, LogLevel.debug, message);

  void warn(String message, Type type) => _log(type, LogLevel.warn, message);

  void error(String message, Type type, {Object? error, StackTrace? stackTrace}) =>
      _log(type, LogLevel.error, message, error: error, stackTrace: stackTrace);
}
