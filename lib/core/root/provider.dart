import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controllers/root_controller.dart';
import 'controllers/root_state.dart';

final rootControllerProvider = NotifierProvider<RootController, RootState>(() {
  return RootController();
});
