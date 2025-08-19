import '../../../domain/entities/schedule/exam_filter.dart';
import '../../models/schedule/exam_filter_model.dart';

class ExamFilterMapper {
  static ExamFilter toEntity({required ExamFilterModel examFilter}) {
    return ExamFilter(
      lessonTypeAbbrevs: examFilter.lessonTypeAbbrevs,
    );
  }
}
