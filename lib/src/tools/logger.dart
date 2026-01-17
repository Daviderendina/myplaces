import 'package:flutter/foundation.dart';

enum LogLevel { info, debug, warn, error }

class AppLogger {
  const AppLogger({this.tag = 'APP'});

  final String tag;

  void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final time = DateTime.now().toIso8601String();
    final prefix = '[$time][$tag][${level.name.toUpperCase()}]';
    debugPrint('$prefix $message');

    if (error != null) debugPrint('Error: $error');
    if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
  }

  void info(String message) => _log(LogLevel.info, message);

  void debug(String message) => _log(LogLevel.debug, message);

  void warn(String message) => _log(LogLevel.warn, message);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}

final logger = AppLogger();
