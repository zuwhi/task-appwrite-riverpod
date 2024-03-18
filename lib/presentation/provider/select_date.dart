import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'select_date.g.dart';

@Riverpod(keepAlive: true)
class SelectDate extends _$SelectDate {
  String today = DateTime.now().toString().substring(0, 10);
  int getDay = int.parse(DateFormat('d').format(DateTime.now())) - 1;
  @override
  SelectDateState build() => SelectDateState(date: today, selectIndex: getDay);

  changeStateDate(String date) async {
    state = SelectDateState(date: date, selectIndex: state.selectIndex);
  }

  changeStateDateIndex(int index) async {
    state = SelectDateState(date: state.date, selectIndex: index);
  }
}

class SelectDateState {
  final String date;
  final int? selectIndex;

  SelectDateState({required this.date, this.selectIndex});
}
