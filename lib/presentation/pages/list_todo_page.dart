// import 'package:appwrite_todo/data/model/Task.dart';
// import 'package:appwrite_todo/presentation/provider/task_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ListTodoPage extends ConsumerStatefulWidget {
//   const ListTodoPage({super.key});

//   @override
//   ConsumerState<ListTodoPage> createState() => _ListTodoPageState();
// }

// class _ListTodoPageState extends ConsumerState<ListTodoPage> {
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(taskNotifierProvider.notifier).getListTask();
//     });
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo'),
//         centerTitle: true,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => buildAdd(),
//         child: const Icon(Icons.add),
//       ),
//       body: Consumer(
//         builder: (context, wiRef, child) {
//           TaskState state = wiRef.watch(taskNotifierProvider);
//           if (state.status == '') return const SizedBox.shrink();
//           if (state.status == 'loading') {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state.status == 'failed') {
//             return Center(
//               child: Text(state.message),
//             );
//           }
//           List<Task> todos = state.data;
//           return ListView.builder(
//             itemCount: todos.length,
//             itemBuilder: (context, index) {
//               Task todo = todos[index];
//               return ListTile(
//                 title: Text(todo.title ?? ''),
//                 subtitle: Text(todo.desc ?? ''),
//                 onTap: () {
//                   buildUpdate(todo);
//                 },
//                 trailing: IconButton(
//                   onPressed: () {
//                     wiRef
//                         .read(taskNotifierProvider.notifier)
//                         .removeTask(todo.id!);
//                   },
//                   icon: const Icon(Icons.delete),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   buildAdd() {
//     final edtTitle = TextEditingController();
//     final edtDesc = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: const Text('Add Todo'),
//         contentPadding: const EdgeInsets.all(20),
//         children: [
//           TextField(controller: edtTitle),
//           const SizedBox(height: 20),
//           TextField(controller: edtDesc),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               final todoAdd = Task(title: edtTitle.text, desc: edtDesc.text);
//               ref.read(taskNotifierProvider.notifier).addTask(todoAdd, context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   buildUpdate(Task oldTodo) {
//     final edtTitle = TextEditingController();
//     final edtDesc = TextEditingController();
//     edtTitle.text = oldTodo.title!;
//     edtDesc.text = oldTodo.desc!;
//     showDialog(
//       context: context,
//       builder: (context) => SimpleDialog(
//         title: const Text('Update Todo'),
//         contentPadding: const EdgeInsets.all(20),
//         children: [
//           TextField(controller: edtTitle),
//           const SizedBox(height: 20),
//           TextField(controller: edtDesc),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Task todoUpdated = oldTodo.copyWith(
//                 title: edtTitle.text,
//                 desc: edtDesc.text,
//               );
//               ref.read(taskNotifierProvider.notifier).updateTask(todoUpdated);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
// }
