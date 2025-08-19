import 'subject.dart';

class Exam extends Subject {
  const Exam({
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
    required this.examDate,
  });

  final DateTime examDate;

  @override
  List<Object?> get props => [...super.props, examDate];
}
