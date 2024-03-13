import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class DateTask extends StatefulWidget {
  const DateTask({
    super.key,
  });

  @override
  State<DateTask> createState() => _DateTaskState();
}

class _DateTaskState extends State<DateTask> {
  @override
  List<int> data = [];

  void populateDataList() {
    for (int i = 1; i <= 29; i++) {
      data.add(i);
    }
  }

  int _focusedIndex = 2;
  @override
  void initState() {
    super.initState();
    populateDataList();
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
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
                  "Maret",
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
                  "senin",
                  style: TextStyle(
                      fontSize: 15.0,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      // color: Colors.amber,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ScrollSnapList(
              // onItemFocus: _onItemFocus,

              itemSize: 75,
              itemBuilder: _buildListItem,
              dynamicItemSize: true,
              // updateOnScroll: true,
              focusOnItemTap: true,
              selectedItemAnchor: SelectedItemAnchor.MIDDLE,
              itemCount: data.length,

              onReachEnd: () {
                print('done');
              },
              onItemFocus: _onItemFocus,
            ),
          ),
        ],
      ),
    );
  }
}

// ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 child: DateCard(),
//               ),
//             );
//           }),

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      width: 50,
      child: const Text('data'),
    );
  }
}
