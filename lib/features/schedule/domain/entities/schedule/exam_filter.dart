import 'package:equatable/equatable.dart';

class ExamFilter extends Equatable {
  const ExamFilter({required this.lessonTypeAbbrevs});

  final Set<String> lessonTypeAbbrevs;

  @override
  List<Object?> get props => [lessonTypeAbbrevs];
}
