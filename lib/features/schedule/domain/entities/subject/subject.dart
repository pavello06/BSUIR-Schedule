import 'package:equatable/equatable.dart';

import '../employee/employee.dart';
import '../group/group.dart';

abstract class Subject extends Equatable {
  const Subject({
    required this.weekNumbers,
    required this.auditories,
    required this.startLessonTime,
    required this.endLessonTime,
    required this.lessonTypeAbbrev,
    required this.numSubgroup,
    required this.subject,
    required this.subjectFullName,
    required this.note,
    required this.groups,
    required this.employees,
  });

  final List<int> weekNumbers;
  final List<String>? auditories;
  final String startLessonTime;
  final String endLessonTime;
  final String lessonTypeAbbrev;
  final int numSubgroup;
  final String subject;
  final String subjectFullName;
  final String? note;
  final List<Group> groups;
  final List<Employee>? employees;

  @override
  List<Object?> get props => [
    weekNumbers,
    auditories,
    startLessonTime,
    endLessonTime,
    lessonTypeAbbrev,
    numSubgroup,
    subject,
    subjectFullName,
    note,
    groups,
    employees,
  ];
}
