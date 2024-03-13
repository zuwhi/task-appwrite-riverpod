import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InProgress extends ConsumerStatefulWidget {
  const InProgress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InProgressState();
}

class _InProgressState extends ConsumerState<InProgress> {
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.blue.withOpacity(0.5),
      Colors.red.withOpacity(0.5),
      Colors.orange.withOpacity(0.5),
      Colors.green.withOpacity(0.5),
      Colors.indigo.withOpacity(0.5),
      Colors.purple.withOpacity(0.5),
      Colors.pink.withOpacity(0.5),
      Colors.orange.withOpacity(0.5),
    ];

    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'In Progress',
              style: GoogleFonts.lexendDeca(
                  fontSize: 26, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
              height: 130,
              child: Consumer(builder: (context, wiRef, child) {
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
                  List<Task> dataTask = state.data;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: dataTask.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: InkWell(
                              child: BoxProgress(
                                  colors: colors,
                                  index: index,
                                  dataTask: dataTask[index])));
                    },
                  );
                }
                return Container();
              }))
        ],
      ),
    );
  }
}

// BoxProgress(colors: _colors, index: index)
class BoxProgress extends StatelessWidget {
  const BoxProgress(
      {super.key, required List<Color> colors, required index, dataTask})
      : _colors = colors,
        index = index,
        dataTask = dataTask;

  final List<Color> _colors;
  final int index;
  final dataTask;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(18),
        // height: 150,
        width: 210,
        decoration: BoxDecoration(
          color: _colors[index],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dataTask.category['name']}',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.work,
                    color: _colors[index],
                    size: 16,
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   height: 14.0,
            // ),
            Text(
              '${dataTask.title}',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              // padding: EdgeInsets.symmetric(
              //   vertical: MediaQuery.of(context).size.height * 0.015,
              // ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: LinearPercentIndicator(
                    // width: 200,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 2500,
                    percent: 0.8,
                    barRadius: const Radius.circular(16),
                    progressColor: _colors[index].withOpacity(1),
                    backgroundColor: Colors.white.withOpacity(0.3),
                  )),
            )
          ],
        ));
  }
}
