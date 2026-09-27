import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/controllers/add_collection_state.dart';
import 'package:myplaces/logger.dart';

import '../providers.dart';
import '../services/collections_service.dart';

enum ValidationStatus {
  valid("", true),
  emptyName('Inserisci il nome della collezione', false),
  noEmoji('Seleziona un emoji', false);

  final String? error;
  final bool isValid;

  const ValidationStatus(this.error, this.isValid);
}

class AddCollectionController extends Notifier<AddCollectionState> {
  late final CollectionService _service;

  @override
  AddCollectionState build() {
    _service = ref.read(collectionsServiceProvider);

    return AddCollectionState();
  }

  void setValues({String? name, String? emoji}) {
    AppLogger.info("Setting values: $name, $emoji", AddCollectionController);
    state = state.copyWith(name: name ?? state.name, emoji: emoji ?? state.emoji);
  }

  ValidationStatus validateValues() {
    AppLogger.info(
      "Validating values | name: ${state.name}, emoji: ${state.emoji}",
      AddCollectionController,
    );

    if (state.name?.isEmpty ?? true) return ValidationStatus.emptyName;
    if (state.emoji?.isEmpty ?? true) return ValidationStatus.noEmoji;

    return ValidationStatus.valid;
  }

  Future<bool> saveCollection() async {
    final status = validateValues();
    if (!status.isValid) {
      AppLogger.warn("Validation failed: ${status.error}", AddCollectionController);
      return false;
    }

    state = state.copyWith(isSaving: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return await _service.addCollection(state.name!, state.emoji!);
    } catch (e, st) {
      AppLogger.error("Error saving collection: $e - $st", AddCollectionController);
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
