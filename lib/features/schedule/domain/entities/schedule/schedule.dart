import 'package:equatable/equatable.dart';

import '../subject/exam.dart';
import '../subject/lesson.dart';
import 'exam_filter.dart';
import 'lesson_filter.dart';

abstract class Schedule extends Equatable {
  const Schedule({
    required this.title,
    required this.lessons,
    required this.lessonFilter,
    required this.exams,
    required this.examFilter,
    required this.lessonsStartDate,
    required this.lessonsEndDate,
  });

  final String? title;
  final Map<int, Map<String, List<Lesson>>>? lessons;
  final LessonFilter? lessonFilter;
  final List<Exam>? exams;
  final ExamFilter? examFilter;
  final DateTime lessonsStartDate;
  final DateTime lessonsEndDate;

  @override
  List<Object?> get props => [
    title,
    lessons,
    lessonFilter,
    exams,
    examFilter,
    lessonsStartDate,
    lessonsEndDate,
  ];
}
