import 'package:appwrite_todo/data/appwrite/appwrite_category_repository.dart';
import 'package:appwrite_todo/data/appwrite/appwrite_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_category.g.dart';

@Riverpod(keepAlive: true)
class SelectCategory extends _$SelectCategory {
  @override
  String build() => 'all';

  changeCategory(String id) => state = id;
}
