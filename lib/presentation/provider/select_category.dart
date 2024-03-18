// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:appwrite_todo/data/appwrite/appwrite_category_repository.dart';
import 'package:appwrite_todo/data/appwrite/appwrite_task.dart';

part 'select_category.g.dart';

@Riverpod(keepAlive: true)
class SelectCategory extends _$SelectCategory {
  @override
  SelectCategoryState build() =>
      SelectCategoryState(category: 'all', selectIndex: -1);

  changeStateCategory(String categoryState) async {
    state = SelectCategoryState(
        category: categoryState, selectIndex: state.selectIndex);
  }

  changeStateCategoryIndex(int index) async {
    state = SelectCategoryState(category: state.category, selectIndex: index);
  }
}

class SelectCategoryState {
  final String category;
  final int? selectIndex;

  SelectCategoryState({required this.category, this.selectIndex});
}


// class SelectCategoryNotifier extends StateNotifier<SelectCategoryState> {
//   SelectCategoryNotifier()
//       : super(SelectCategoryState(category: 'all', selectIndex: 1));

//   changeStateCategory(String categoryState) {
//     state = state.copyWith(category: categoryState);
//   }

//   changeStateIndex(int index) {
//     state = state.copyWith(selectIndex: index);
//   }

//   changeStateBothCategory(String categoryState, int index) {
//     state = state.copyWith(category: categoryState, selectIndex: index);
//   }
// }
