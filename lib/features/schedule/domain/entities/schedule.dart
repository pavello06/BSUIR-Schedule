import 'package:equatable/equatable.dart';

import 'exam.dart';
import 'lesson.dart';

abstract class Schedule extends Equatable {
  const Schedule({
    required this.lessons,
    required this.exams,
    required this.lessonsStartDate,
    required this.lessonsEndDate,
  });

  final Map<int, Map<String, List<Lesson>>> lessons;
  final List<Exam> exams;
  final DateTime lessonsStartDate;
  final DateTime lessonsEndDate;

  @override
  List<Object?> get props => [lessons, exams, lessonsStartDate, lessonsEndDate];
}
