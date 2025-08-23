import '../../../domain/entities/schedule/saved_schedule.dart';
import '../../models/schedule/saved_schedule_model.dart';
import '../employee/employee_mapper.dart';
import '../group/faculty_mapper.dart';
import '../group/group_mapper.dart';
import '../group/speciality_mapper.dart';

class SavedScheduleMapper {
  static SavedSchedule toEntity({required SavedScheduleModel savedSchedule}) {
    return SavedSchedule(
      isActive: savedSchedule.isActive,
      query: savedSchedule.query,
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
      title: savedSchedule.title,
    );
  }

  static SavedScheduleModel toModel({required SavedSchedule savedSchedule}) {
    return SavedScheduleModel(
      isActive: savedSchedule.isActive,
      query: savedSchedule.query,
      isGroup: savedSchedule.isGroup,
      group: savedSchedule.isGroup ? GroupMapper.toModel(group: savedSchedule.group!) : null,
      faculty: savedSchedule.isGroup
          ? FacultyMapper.toModel(faculty: savedSchedule.group!.faculty)
          : null,
      speciality: savedSchedule.isGroup
          ? SpecialityMapper.toModel(speciality: savedSchedule.group!.speciality)
          : null,
      employee: !savedSchedule.isGroup
          ? EmployeeMapper.toModel(employee: savedSchedule.employee!)
          : null,
      title: savedSchedule.title,
    );
  }
}
