import 'dart:math';
import 'package:appwrite_todo/presentation/provider/select_date.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class DateTask extends ConsumerStatefulWidget {
  const DateTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DateTaskState();
}

class _DateTaskState extends ConsumerState<DateTask> {
  List<int> data = [];
  String nowDate = '0';
  DateTime? monthEnd;
  int? dayLength;
  DateTime today = DateTime.now();
  String? selectDate;

  DateTime? monthNow;

  // double _focusedIndex =
  //     double.parse(DateFormat('d').format(DateTime.now())) - 1;

  int? _focusedIndex;
  @override
  void initState() {
    super.initState();
    populateDataList();
    // Logger().d(_focusedIndex);
  }

  void populateDataList() {
    monthNow = DateTime(today.year, today.month, 0);
    monthEnd = DateTime(today.year, today.month + 1, 0);
    dayLength = monthEnd!.day;

    for (int i = 1; i <= dayLength!; i++) {
      data.add(i);
    }
  }

  void _onItemFocus(int index, WidgetRef wiref) {
    setState(() {
      _focusedIndex = index;
      ref.read(selectDateProvider.notifier).changeStateDateIndex(index);

      selectDate = DateFormat('yyyy-MM-dd')
          .format(DateTime(today.year, today.month, index + 1));
      selectDate!.substring(0, 10);
    });

    // Logger().d(DateFormat('yyyy-MM-dd')
    //     .format(DateTime(today.year, today.month, index + 1))
    //     .toString());
    ref.read(selectDateProvider.notifier).changeStateDate(
        DateFormat('yyyy-MM-dd')
            .format(DateTime(today.year, today.month, index + 1))
            .toString());
    ref.read(taskNotifierProvider.notifier).getListBySelectCategory();
  }

  @override
  Widget build(BuildContext context) {
    final focusedIndex = ref.read(selectDateProvider);
    _focusedIndex = (focusedIndex.selectIndex ?? -1);
    return SizedBox(
      height: 100,
      // color: Colors.amber,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ScrollSnapList(
              initialIndex: _focusedIndex!.toDouble(),
              itemSize: 75,
              itemBuilder: _buildListItem,
              dynamicItemSize: true,
              focusOnItemTap: true,
              selectedItemAnchor: SelectedItemAnchor.MIDDLE,
              itemCount: data.length,
              // focusToItem: (p0) => _focusedIndex,
              onReachEnd: () {
                print('done');
              },
              onItemFocus: (p0) {
                _onItemFocus(p0, ref);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final currentDate = monthNow!.add(Duration(days: index + 1));
    var bulan = DateFormat('MMMM').format(DateTime(0, today.month));
    var hari = DateFormat('EEEE').format(currentDate);

    if (index == data.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    bool isFocused = index == _focusedIndex;
    return Container(
      width: 65,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isFocused ? const Color(0xFF5F33E1) : Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  color: Color.fromARGB(138, 158, 158, 158),
                ),
              ],
            ),
            height: 90,
            child: Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  bulan,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: isFocused ? Colors.white : Colors.black),
                ),
                Text(
                  "${data[index]}",
                  style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w600,
                      color: isFocused ? Colors.white : Colors.black),
                ),
                Text(
                  hari,
                  style: TextStyle(
                      fontSize: 12.0,
                      color: isFocused ? Colors.white : Colors.black),
                ),
                const SizedBox(
                  height: 3.0,
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
