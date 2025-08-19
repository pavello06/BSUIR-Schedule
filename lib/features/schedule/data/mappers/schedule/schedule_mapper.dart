import 'package:intl/intl.dart';

import '../../../domain/entities/group/group.dart';
import '../../../domain/entities/schedule/employee_schedule.dart';
import '../../../domain/entities/schedule/exam_filter.dart';
import '../../../domain/entities/schedule/group_schedule.dart';
import '../../../domain/entities/schedule/lesson_filter.dart';
import '../../../domain/entities/subject/lesson.dart';
import '../../models/schedule/schedule_model.dart';
import '../subject/subject_employee_mapper.dart';
import '../subject/subject_mapper.dart';
import 'exam_filter_mapper.dart';
import 'lesson_filter_mapper.dart';

class ScheduleMapper {
  static GroupSchedule toGroupSchedule({
    required ScheduleModel schedule,
    required Map<String, Group> groupMap,
  }) {
    final lessons = _getLessons(schedule, groupMap);

    return GroupSchedule(
      title: schedule.title,
      lessons: lessons,
      lessonFilter: _getLessonFilter(lessons, schedule),
      exams: schedule.exams
          ?.map((lesson) => SubjectMapper.toExam(subject: lesson, groupMap: groupMap))
          .toList(),
      examFilter: _getExamFilter(schedule),
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
    final lessons = _getLessons(schedule, groupMap);

    return EmployeeSchedule(
      title: schedule.title,
      lessons: lessons,
      lessonFilter: _getLessonFilter(lessons, schedule),
      exams: schedule.exams
          ?.map((lesson) => SubjectMapper.toExam(subject: lesson, groupMap: groupMap))
          .toList(),
      examFilter: _getExamFilter(schedule),
      lessonsStartDate: DateFormat('dd.MM.yyyy').parse(schedule.startDate),
      lessonsEndDate: DateFormat('dd.MM.yyyy').parse(schedule.endDate),
      employee: SubjectEmployeeMapper.toEntity(employee: schedule.employeeDto!),
    );
  }

  static Map<int, Map<String, List<Lesson>>>? _getLessons(
    ScheduleModel schedule,
    Map<String, Group> groupMap,
  ) {
    bool isEmpty = true;
    for (final lessons in schedule.schedules.entries) {
      if (lessons.value.isNotEmpty) {
        isEmpty = false;
        break;
      }
    }
    if (isEmpty) {
      return null;
    }

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

  static LessonFilter? _getLessonFilter(
    Map<int, Map<String, List<Lesson>>>? lessons,
    ScheduleModel schedule,
  ) {
    LessonFilter? lessonFilter;
    if (schedule.lessonFilter != null) {
      lessonFilter = LessonFilterMapper.toEntity(lessonFilter: schedule.lessonFilter!);
    } else {
      if (lessons != null) {
        var startDate = DateTime.now();
        final lessonStartDate = DateFormat('dd.MM.yyyy').parse(schedule.startDate);
        startDate = startDate.isAfter(lessonStartDate) ? startDate : lessonStartDate;

        var endDate = startDate.add(Duration(days: 30));
        final lessonEndDate = DateFormat('dd.MM.yyyy').parse(schedule.endDate);
        endDate = endDate.isBefore(lessonEndDate) ? endDate : lessonEndDate;

        lessonFilter = LessonFilter(
          numSubgroups: {0, 1, 2},
          lessonTypeAbbrevs: {'ЛК', 'ПЗ', 'ЛР'},
          subjects: {},
          startDate: startDate,
          endDate: endDate,
        );
        for (final lessons in schedule.schedules.entries) {
          for (final lesson in lessons.value) {
            lessonFilter.subjects.add(lesson.subject);
          }
        }
      } else {
        lessonFilter = null;
      }
    }

    return lessonFilter;
  }

  static ExamFilter? _getExamFilter(ScheduleModel schedule) {
    ExamFilter? examFilter;
    if (schedule.examFilter != null) {
      examFilter = ExamFilterMapper.toEntity(examFilter: schedule.examFilter!);
    } else {
      if (schedule.exams != null) {
        examFilter = ExamFilter(lessonTypeAbbrevs: {'Консультация', 'Экзамен'});
      } else {
        examFilter = null;
      }
    }

    return examFilter;
  }
}
