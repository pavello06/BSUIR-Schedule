import '../../../domain/entities/schedule/lesson_filter.dart';
import '../../models/schedule/lesson_filter_model.dart';

class LessonFilterMapper {
  static LessonFilter toEntity({required LessonFilterModel lessonFilter}) {
    return LessonFilter(
      numSubgroups: lessonFilter.numSubgroups,
      lessonTypeAbbrevs: lessonFilter.lessonTypeAbbrevs,
      subjects: lessonFilter.subjects,
      startDate: lessonFilter.startDate,
      endDate: lessonFilter.endDate,
    );
  }
}
