import 'package:equatable/equatable.dart';

import 'subject/subject.dart';

class StudyDay extends Equatable {
  const StudyDay({required this.dateTime, required this.subjects});

  final DateTime dateTime;
  final List<Subject> subjects;

  @override
  List<Object?> get props => [dateTime, subjects];
}
