import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskGroups extends ConsumerWidget {
  const TaskGroups({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> colors = [
      Colors.orange.withOpacity(0.2),
      Colors.green.withOpacity(0.2),
      Colors.blue.withOpacity(0.2),
      Colors.red.withOpacity(0.2),
      Colors.indigo.withOpacity(0.2),
      Colors.purple.withOpacity(0.2),
      Colors.pink.withOpacity(0.2),
      Colors.orange.withOpacity(0.2),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Task Groups',
        style:
            GoogleFonts.lexendDeca(fontSize: 26, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        child: Consumer(
          builder: (context, ref, child) {
            TaskCategoryGroups state = ref.watch(taskCategoryNotifierProvider);
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
              List data = state.data;

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // Logger().d(data[index].tasks);

                  num percent =
                      data[index].doneTotal / data[index].tasks.length * 100;

                  // Logger().d(percent);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colors[index],
                        ),
                        padding: const EdgeInsets.all(13),
                        child: Icon(
                          Icons.work,
                          color: colors[index].withOpacity(1),
                        ),
                      ),
                      title: Text(
                        '${data[index].name}',
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${data[index].tasks.length} Task',
                        style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]),
                      ),
                      trailing: Container(
                        child: CircularPercentIndicator(
                          radius: 24.0,
                          lineWidth: 4.0,
                          animation: true,
                          percent: percent * 0.01,
                          center: Text(
                            "${percent.toStringAsFixed(0)}%",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: Colors.grey[700]),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: colors[index].withOpacity(1),
                          backgroundColor: colors[index],
                        ),
                      ),
                      // isThreeLine: true,
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    ]);
  }
}
