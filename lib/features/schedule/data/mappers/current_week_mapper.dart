import '../../domain/entities/current_week.dart';
import '../models/current_week_model.dart';

class CurrentWeekMapper {
  static CurrentWeek toEntity({required CurrentWeekModel currentWeek}) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(currentWeek.dateTime);
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - 1));

    return CurrentWeek(
      week: currentWeek.week,
      dateTime: dateTime,
    );
  }
}
