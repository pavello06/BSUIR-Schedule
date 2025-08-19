import 'package:intl/intl.dart';

import '../../../domain/entities/schedule/schedule_last_update.dart';
import '../../models/schedule/schedule_last_update_model.dart';

class ScheduleLastUpdateMapper {
  static ScheduleLastUpdate toEntity({required ScheduleLastUpdateModel scheduleLastUpdate}) {
    return ScheduleLastUpdate(
      dateTime: DateFormat('dd.MM.yyyy').parse(scheduleLastUpdate.lastUpdateDate),
    );
  }
}
