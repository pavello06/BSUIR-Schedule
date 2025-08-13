import 'package:intl/intl.dart';

import '../../domain/entities/employee_schedule.dart';
import '../../domain/entities/group_schedule.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/lesson.dart';
import '../models/schedule_model.dart';
import 'subject_employee_mapper.dart';
import 'subject_mapper.dart';

class ScheduleMapper {
  static GroupSchedule toGroupSchedule({
    required ScheduleModel schedule,
    required Map<String, Group> groupMap,
  }) {
    return GroupSchedule(
      lessons: _getLessons(schedule, groupMap),
      exams: schedule.exams
          .map(
            (lesson) =>
                SubjectMapper.toExam(subject: lesson, groupMap: groupMap),
          )
          .toList(),
      lessonsStartDate: DateFormat('dd.MM.yyyy').parse(schedule.startDate),
      lessonsEndDate: DateFormat('dd.MM.yyyy').parse(schedule.endDate),
      examsStartDate: DateFormat('dd.MM.yyyy').parse(schedule.startExamsDate!),
      examsEndDate: DateFormat('dd.MM.yyyy').parse(schedule.endExamsDate!),
      group: groupMap[schedule.studentGroupDto!.name]!,
    );
  }

  static EmployeeSchedule toEmployeeSchedule({
    required ScheduleModel schedule,
    required Map<String, Group> groupMap,
  }) {
    return EmployeeSchedule(
      lessons: _getLessons(schedule, groupMap),
      exams: schedule.exams
          .map(
            (lesson) =>
                SubjectMapper.toExam(subject: lesson, groupMap: groupMap),
          )
          .toList(),
      lessonsStartDate: DateFormat('dd.MM.yyyy').parse(schedule.startDate),
      lessonsEndDate: DateFormat('dd.MM.yyyy').parse(schedule.endDate),
      employee: SubjectEmployeeMapper.toEntity(employee: schedule.employeeDto!),
    );
  }

  static Map<int, Map<String, List<Lesson>>> _getLessons(
    ScheduleModel schedule,
    Map<String, Group> groupMap,
  ) {
    final preparedLessons = <int, Map<String, List<Lesson>>>{
      1: {
        'Понедельник': [],
        'Вторник': [],
        'Среда': [],
        'Четверг': [],
        'Пятница': [],
        'Суббота': [],
      },
      2: {
        'Понедельник': [],
        'Вторник': [],
        'Среда': [],
        'Четверг': [],
        'Пятница': [],
        'Суббота': [],
      },
      3: {
        'Понедельник': [],
        'Вторник': [],
        'Среда': [],
        'Четверг': [],
        'Пятница': [],
        'Суббота': [],
      },
      4: {
        'Понедельник': [],
        'Вторник': [],
        'Среда': [],
        'Четверг': [],
        'Пятница': [],
        'Суббота': [],
      },
    };
    for (final lessons in schedule.schedules.entries) {
      for (final lesson in lessons.value) {
        for (final weekNumber in lesson.weekNumber) {
          preparedLessons[weekNumber]![lessons.key]!.add(
            SubjectMapper.toLesson(subject: lesson, groupMap: groupMap),
          );
        }
      }
    }

    return preparedLessons;
  }
}
