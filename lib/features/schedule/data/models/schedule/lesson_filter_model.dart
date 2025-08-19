class LessonFilterModel {
  LessonFilterModel({
    required this.numSubgroups,
    required this.lessonTypeAbbrevs,
    required this.subjects,
    required this.startDate,
    required this.endDate,
  });

  final Set<int> numSubgroups;
  final Set<String> lessonTypeAbbrevs;
  final Set<String> subjects;
  final DateTime startDate;
  final DateTime endDate;
}
