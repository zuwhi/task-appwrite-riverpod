import 'package:appwrite_todo/data/appwrite/appwrite_category_repository.dart';
import 'package:appwrite_todo/data/appwrite/appwrite_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_category_groups.g.dart';

@riverpod
class TaskCategoryNotifier extends _$TaskCategoryNotifier {
  @override
  TaskCategoryGroups build() =>
      TaskCategoryGroups(status: '', message: '', data: []);
  final appwriteTask = AppwriteTaskRepository();
  final appwriteCategory = AppwriteCategoryRepository();

  getListCategory() async {
    // state = TaskCategoryGroups(status: 'loading', message: '', data: []);
    final data = await appwriteCategory.listCategory();
    if (data == null) {
      state = TaskCategoryGroups(status: 'failed', message: '', data: []);
    } else {
      state = TaskCategoryGroups(status: 'success', message: '', data: data);
    }
  }

  Future<List<String>?> getListNameCategory() async {
    final data = await appwriteCategory.listNameCategory();
    return data;
  }

  getCategoryById(String id) async {
    final data = await appwriteCategory.listCategoryById(id);
    if (data == null) {
      state = TaskCategoryGroups(status: 'failed', message: '', data: []);
    } else {
      state = TaskCategoryGroups(status: 'success', message: '', data: data);
    }
  }

  addTaskOnCategory(String category, String task) async {
    await appwriteCategory.updateDocument(category, task);
  }
}

class TaskCategoryGroups {
  final String status;
  final String message;
  final List data;
  TaskCategoryGroups({
    required this.status,
    required this.message,
    required this.data,
  });
}
