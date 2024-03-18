import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'select_date.g.dart';

@Riverpod(keepAlive: true)
class SelectDate extends _$SelectDate {
  String today = DateTime.now().toString().substring(0, 10);
  @override
  String build() => today;

  changeDate(String date) => state = date;
}
