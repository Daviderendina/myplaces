import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/my_list.dart';

class SavedPageState {
  final List<MyList> lists;
  final bool isLoading;

  const SavedPageState({this.lists = const [], this.isLoading = false});

  SavedPageState copyWith({List<MyList>? lists, bool? isLoading}) {
    return SavedPageState(
      lists: lists ?? this.lists,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
