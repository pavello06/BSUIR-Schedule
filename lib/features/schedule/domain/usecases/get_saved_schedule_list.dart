import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/saved_schedule.dart';
import '../repositories/schedule_repository.dart';

class GetSavedScheduleList extends UseCase<List<SavedSchedule>, NoParams> {
  GetSavedScheduleList({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<SavedSchedule>>> call(NoParams params) async {
    return await repository.getSavedScheduleList();
  }
}
