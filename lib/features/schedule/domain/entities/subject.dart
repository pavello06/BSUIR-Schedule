import 'package:equatable/equatable.dart';

import 'employee.dart';
import 'group.dart';

abstract class Subject extends Equatable {
  const Subject({
    required this.auditories,
    required this.endLessonTime,
    required this.lessonTypeAbbrev,
    required this.note,
    required this.numSubgroup,
    required this.startLessonTime,
    required this.groups,
    required this.subject,
    required this.subjectFullName,
    required this.weekNumbers,
    required this.employees,
  });

  final List<String>? auditories;
  final String endLessonTime;
  final String lessonTypeAbbrev;
  final String? note;
  final int numSubgroup;
  final String startLessonTime;
  final List<Group> groups;
  final String subject;
  final String subjectFullName;
  final List<int> weekNumbers;
  final List<Employee>? employees;

  @override
  List<Object?> get props => [
    auditories,
    endLessonTime,
    lessonTypeAbbrev,
    note,
    numSubgroup,
    startLessonTime,
    groups,
    subject,
    subjectFullName,
    weekNumbers,
    employees,
  ];
}
