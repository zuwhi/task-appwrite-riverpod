import 'package:appwrite_todo/data/appwrite/appwrite_task.dart';
import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/presentation/provider/select_category.dart';
import 'package:appwrite_todo/presentation/provider/select_date.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:equatable/equatable.dart';

part 'task_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  TaskState build() => const TaskState('', '', []);
  final appwriteTask = AppwriteTaskRepository();

  getListTask() async {
    state = const TaskState('loading', '', []);
    final tasks = await appwriteTask.listDocument();
    if (tasks == null) {
      state = const TaskState('failed', 'kosong', []);
    } else {
      state = TaskState('success', '', tasks ?? []);
    }
  }

  addTask(Task task, context, kategori) async {
    state = const TaskState('loading', '', []);
    String tasks = await appwriteTask.createDocument(task, context);
    Logger().d(tasks);
    ref
        .read(taskCategoryNotifierProvider.notifier)
        .addTaskOnCategory(kategori, tasks);
    await getListTask();
  }

  updateTask(Task task, kategori) async {
    final tasks = await appwriteTask.updateDocument(task);
    if (tasks == null) {
      ref
          .read(taskCategoryNotifierProvider.notifier)
          .addTaskOnCategory(kategori, task.id!);
      await getListBySelectCategory();
    } else {
      ref
          .read(taskCategoryNotifierProvider.notifier)
          .addTaskOnCategory(kategori, task.id!);
      print('update');
      getListBySelectCategory();
    }
  }

  removeTask(String id) async {
    state = const TaskState('loading', '', []);
    final tasks = await appwriteTask.removeReminder(id);
    if (tasks == null) {
      state = const TaskState('failed', 'kosong', []);
    } else {
      getListBySelectCategory();
    }
  }

  getListBySelectCategory() async {
    state = const TaskState('loading', '', []);
    print('load');
    final selectCategory = ref.watch(selectCategoryProvider);
    final selectDate = ref.watch(selectDateProvider);
    // Logger().d(selectCategory);
    Logger().d(selectDate);
    final tasks =
        await appwriteTask.listDocumentByCategory(selectCategory, selectDate);
    // Logger().d(tasks);
    if (tasks == null) {
      state = const TaskState('failed', 'kosong', []);
    } else {
      state = TaskState('success', '', tasks);
    }
  }
}

class TaskState extends Equatable {
  final String status;
  final String message;
  final List<Task> data;
  const TaskState(
    this.status,
    this.message,
    this.data,
  );

  @override
  // Task: implement props
  List<Object> get props => [status, message, data];
}


 // getListTaskByCategory(String category) async {
  //   state = const TaskState('loading', '', []);
  //   final tasks = await appwriteTask.listDocumentByCategory(category);
  //   if (tasks == null) {
  //     state = const TaskState('failed', 'kosong', []);
  //   } else {
  //     state = TaskState('success', '', tasks);
  //   }
  // }