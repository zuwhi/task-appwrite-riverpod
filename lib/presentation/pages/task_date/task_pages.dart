import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/presentation/pages/detail_task/add_task.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:appwrite_todo/presentation/pages/task_date/widget/CategoryTask.dart';
import 'package:appwrite_todo/presentation/pages/task_date/widget/DateTask.dart';
import 'package:appwrite_todo/presentation/widgets/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(taskNotifierProvider.notifier).getListBySelectCategory();
      ref.read(taskCategoryNotifierProvider.notifier).getListCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            "Today's Task",
            style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: const [
            Icon(Icons.notification_important_outlined),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const DateTask(),
                const SizedBox(
                  height: 17.0,
                ),
                const CategoryTask(),
                const SizedBox(
                  height: 25.0,
                ),
                Consumer(
                  builder: (context, wiRef, child) {
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
                                          .removeTask(tasks[index].id!, false);
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
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class CategoryIcon extends StatelessWidget {
  final category;
  const CategoryIcon({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;

    switch (category) {
      case 'hobi':
        iconData = Icons.face;
        break;

      case 'Pekerjaan':
        iconData = Icons.work;
        break;

      default:
        iconData = Icons.error;
    }

    return Icon(
      iconData,
      color: Colors.white,
    );
  }
}
