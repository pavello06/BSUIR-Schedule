import '../../domain/entities/saved_schedule.dart';
import '../models/saved_schedule_model.dart';
import 'employee_mapper.dart';
import 'group_mapper.dart';

class SavedScheduleMapper {
  static SavedSchedule toEntity({
    required SavedScheduleModel savedSchedule,
  }) {
    return SavedSchedule(
      isGroup: savedSchedule.isGroup,
      group: savedSchedule.isGroup
          ? GroupMapper.toEntity(
              group: savedSchedule.group!,
              faculty: savedSchedule.faculty!,
              speciality: savedSchedule.speciality!,
            )
          : null,
      employee: !savedSchedule.isGroup
          ? EmployeeMapper.toEntity(employee: savedSchedule.employee!)
          : null,
      query: savedSchedule.query,
      isActive: savedSchedule.isActive,
    );
  }
}
