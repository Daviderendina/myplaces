import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/logger.dart';

final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger();
});
