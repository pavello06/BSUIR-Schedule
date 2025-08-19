import 'package:intl/intl.dart';

import '../../../domain/entities/group/group.dart';
import '../../../domain/entities/subject/exam.dart';
import '../../../domain/entities/subject/lesson.dart';
import '../../models/subject/subject_model.dart';
import 'subject_employee_mapper.dart';
import 'subject_group_mapper.dart';

class SubjectMapper {
  static Lesson toLesson({required SubjectModel subject, required Map<String, Group> groupMap}) {
    return Lesson(
      weekNumbers: subject.weekNumber,
      auditories: subject.auditories,
      startLessonTime: subject.startLessonTime,
      endLessonTime: subject.endLessonTime,
      lessonTypeAbbrev: subject.lessonTypeAbbrev,
      numSubgroup: subject.numSubgroup,
      subject: subject.subject,
      subjectFullName: subject.subjectFullName,
      note: subject.note,
      groups: subject.studentGroups
          .map((group) => SubjectGroupMapper.toEntity(group: group, groupMap: groupMap))
          .toList(),
      employees: subject.employees
          ?.map((employee) => SubjectEmployeeMapper.toEntity(employee: employee))
          .toList(),
      lessonStartDate: DateFormat('dd.MM.yyyy').parse(subject.startLessonDate!),
      lessonEndDate: DateFormat('dd.MM.yyyy').parse(subject.endLessonDate!),
    );
  }

  static Exam toExam({required SubjectModel subject, required Map<String, Group> groupMap}) {
    return Exam(
      weekNumbers: subject.weekNumber,
      auditories: subject.auditories,
      startLessonTime: subject.startLessonTime,
      endLessonTime: subject.endLessonTime,
      lessonTypeAbbrev: subject.lessonTypeAbbrev,
      numSubgroup: subject.numSubgroup,
      subject: subject.subject,
      subjectFullName: subject.subjectFullName,
      note: subject.note,
      groups: subject.studentGroups
          .map((group) => SubjectGroupMapper.toEntity(group: group, groupMap: groupMap))
          .toList(),
      employees: subject.employees
          ?.map((employee) => SubjectEmployeeMapper.toEntity(employee: employee))
          .toList(),
      examDate: DateFormat('dd.MM.yyyy').parse(subject.dateLesson!),
    );
  }
}
