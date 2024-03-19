import 'package:appwrite_todo/presentation/pages/detail_task/add_task.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressWidget extends ConsumerWidget {
  const ProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF5F33E1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    // color: Colors.amber,
                    width: 150,
                    child: Text(
                      'Your Total Task Percentage',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaskPage()),
                      );
                    },
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5F33E1)),
                    ))
              ],
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Consumer(
                      builder: (context, ref, child) {
                        TaskCategoryGroups state =
                            ref.watch(taskCategoryNotifierProvider);
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
                          num doneTotal = 0;
                          num totalLength = 0;
                          for (int i = 0; i < data.length; i++) {
                            doneTotal += data[i].doneTotal;
                            totalLength += data[i].tasks.length;
                          }

                          num percent = doneTotal / totalLength * 100;

                          return CircularPercentIndicator(
                            radius: 43.0,
                            lineWidth: 8.0,
                            animation: true,
                            percent: percent * 0.01,
                            center: Text(
                              "${percent.toStringAsFixed(0)}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17.0,
                                  color: Colors.white),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.3),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                        Center(child: SvgPicture.asset('assets/pointer.svg')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
