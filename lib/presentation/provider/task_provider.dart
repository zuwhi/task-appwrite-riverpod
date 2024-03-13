import 'package:appwrite_todo/data/appwrite/appwrite_task.dart';
import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
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
    // Logger().d(task.id);
    if (tasks == null) {
      ref
          .read(taskCategoryNotifierProvider.notifier)
          .addTaskOnCategory(kategori, task.id!);
    } else {
      ref
          .read(taskCategoryNotifierProvider.notifier)
          .addTaskOnCategory(kategori, task.id!);
      await getListTask();
    }
  }

  removeTask(String id) async {
    state = const TaskState('loading', '', []);
    final tasks = await appwriteTask.removeReminder(id);
    if (tasks == null) {
      state = const TaskState('failed', 'kosong', []);
    } else {
      state = TaskState('success', '', tasks ?? []);
    }
  }

  getListTaskByCategory(String category) async {
    state = const TaskState('loading', '', []);
    final tasks = await appwriteTask.listDocumentByCategory(category);
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
