import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/schedule/saved_schedule.dart';
import '../../entities/schedule/schedule.dart';
import '../../repositories/schedule_repository.dart';

class GetActiveSchedule extends UseCase<Schedule?, NoParams> {
  GetActiveSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, Schedule?>> call(NoParams params) async {
    final savedSchedulesOrFailure = await repository.getSavedSchedules();

    return savedSchedulesOrFailure.fold((failure) => Left(failure), (savedSchedules) async {
      SavedSchedule? activeSchedule;
      for (final savedSchedule in savedSchedules) {
        if (savedSchedule.isActive) {
          activeSchedule = savedSchedule;
        }
      }
      if (activeSchedule == null) {
        return Right(null);
      }

      return await (activeSchedule.isGroup
          ? repository.getGroupSchedule(activeSchedule.query)
          : repository.getEmployeeSchedule(activeSchedule.query));
    });
  }
}
