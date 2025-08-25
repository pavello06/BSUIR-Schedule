import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/date_util.dart';
import '../../entities/current_week.dart';
import '../../entities/schedule/schedule.dart';
import '../../entities/study_day.dart';
import '../../entities/subject/subject.dart';
import '../../repositories/schedule_repository.dart';

class GetLessons extends UseCase<List<StudyDay>, GetLessonsParams> {
  GetLessons({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<StudyDay>>> call(GetLessonsParams params) async {
    final lessons = params.schedule.lessons;
    final lessonFilter = params.schedule.lessonFilter!;
    final currentWeek = params.currentWeek;

    final studyDays = <StudyDay>[];
    for (
      var dateTime = lessonFilter.startDate;
      dateTime.isBefore(lessonFilter.endDate.add(Duration(days: 1)));
      dateTime = dateTime.add(Duration(days: 1))
    ) {
      final week =
          (currentWeek.week + dateTime.difference(currentWeek.dateTime).inDays % 7) % 4 + 1;
      final dayOfWeek = DateUtil.getDayOfWeek(dateTime, 'ru');

      final subjects = <Subject>[];
      for (final lesson in lessons![week]![dayOfWeek]!) {
        if (lessonFilter.numSubgroups.contains(lesson.numSubgroup) &&
            lessonFilter.lessonTypeAbbrevs.contains(lesson.lessonTypeAbbrev) &&
            lessonFilter.subjects.contains(lesson.subject)) {
          subjects.add(lesson);
        }
      }
      studyDays.add(StudyDay(dateTime: dateTime, subjects: subjects));
    }

    return Right(studyDays);
  }
}

class GetLessonsParams extends Equatable {
  const GetLessonsParams({required this.schedule, required this.currentWeek});

  final Schedule schedule;
  final CurrentWeek currentWeek;

  @override
  List<Object?> get props => [schedule, currentWeek];
}
