import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/providers.dart';
import 'package:myplaces/src/domain/poi.dart';

class MapSelectionController extends Notifier<Poi?> {
  @override
  Poi? build() {
    return null;
  }

  void select(Poi poi) {
    state = poi;
  }

  void clear() {
    ref
        .read(loggerProvider)
        .debug('Clearing map selection', MapSelectionController);
    state = null;
  }
}
