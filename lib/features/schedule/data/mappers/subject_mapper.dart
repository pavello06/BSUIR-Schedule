import 'package:intl/intl.dart';

import '../../domain/entities/exam.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/group.dart';
import '../models/subject_model.dart';
import 'subject_employee_mapper.dart';
import 'subject_group_mapper.dart';

class SubjectMapper {
  static Lesson toLesson({
    required SubjectModel subject,
    required Map<String, Group> groupMap,
  }) {
    return Lesson(
      auditories: subject.auditories,
      endLessonTime: subject.endLessonTime,
      lessonTypeAbbrev: subject.lessonTypeAbbrev,
      note: subject.note,
      numSubgroup: subject.numSubgroup,
      startLessonTime: subject.startLessonTime,
      groups: subject.studentGroups
          .map(
            (group) =>
                SubjectGroupMapper.toEntity(group: group, groupMap: groupMap),
          )
          .toList(),
      subject: subject.subject,
      subjectFullName: subject.subjectFullName,
      weekNumbers: subject.weekNumber,
      employees: subject.employees
          ?.map(
            (employee) => SubjectEmployeeMapper.toEntity(employee: employee),
          )
          .toList(),
      lessonStartDate: DateFormat('dd.MM.yyyy').parse(subject.startLessonDate!),
      lessonEndDate: DateFormat('dd.MM.yyyy').parse(subject.endLessonDate!),
    );
  }

  static Exam toExam({
    required SubjectModel subject,
    required Map<String, Group> groupMap,
  }) {
    return Exam(
      auditories: subject.auditories,
      endLessonTime: subject.endLessonTime,
      lessonTypeAbbrev: subject.lessonTypeAbbrev,
      note: subject.note,
      numSubgroup: subject.numSubgroup,
      startLessonTime: subject.startLessonTime,
      groups: subject.studentGroups
          .map(
            (group) =>
                SubjectGroupMapper.toEntity(group: group, groupMap: groupMap),
          )
          .toList(),
      subject: subject.subject,
      subjectFullName: subject.subjectFullName,
      weekNumbers: subject.weekNumber,
      employees: subject.employees
          ?.map(
            (employee) => SubjectEmployeeMapper.toEntity(employee: employee),
          )
          .toList(),
      examDate: DateFormat('dd.MM.yyyy').parse(subject.dateLesson!),
    );
  }
}
