import 'subject.dart';

class Lesson extends Subject {
  const Lesson({
    required super.auditories,
    required super.endLessonTime,
    required super.lessonTypeAbbrev,
    required super.note,
    required super.numSubgroup,
    required super.startLessonTime,
    required super.groups,
    required super.subject,
    required super.subjectFullName,
    required super.weekNumbers,
    required super.employees,
    required this.lessonStartDate,
    required this.lessonEndDate,
  });

  final DateTime lessonStartDate;
  final DateTime lessonEndDate;

  @override
  List<Object?> get props => [...super.props, lessonStartDate, lessonEndDate];
}
