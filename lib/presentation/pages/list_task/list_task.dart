import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/presentation/pages/detail_task/detail_task.dart';
import 'package:appwrite_todo/presentation/pages/task_date/task_pages.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:appwrite_todo/presentation/widgets/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ListTaskPage extends ConsumerStatefulWidget {
  const ListTaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends ConsumerState<ListTaskPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(taskNotifierProvider.notifier).getListTaskDesc();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List All Task"),
        centerTitle: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Consumer(builder: (context, wiRef, child) {
                  TaskState state = wiRef.watch(taskNotifierProvider);
                  if (state.status == '') return const SizedBox.shrink();
                  if (state.status == 'loading') {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.status == 'failed') {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state.status == 'success') {
                    List<Task> tasks = state.data;
                    return ListView.builder(
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: Colors.grey.withOpacity(0.1),
                          elevation: 0,
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTaskPage(
                                          isByDate: false,
                                              isEdit: true,
                                              task: tasks[index],
                                            )));
                              },
                              leading: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: Appcolor.ungu,
                                  child: CategoryIcon(
                                      category: tasks[index].category)),
                              title: Text(
                                '${tasks[index].title}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.ungu,
                                ),
                              ),
                              subtitle: Text(
                                '${tasks[index].date}',
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(taskNotifierProvider.notifier)
                                        .removeTask(tasks[index].id!, true);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black54,
                                    size: 22,
                                  ))),
                        );
                      },
                    );
                  }
                  return Container();
                })
              ],
            )),
      ),
    );
  }
}
