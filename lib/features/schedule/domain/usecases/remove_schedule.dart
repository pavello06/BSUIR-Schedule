import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/schedule_repository.dart';

class RemoveSchedule extends UseCase<void, RemoveScheduleParams> {
  RemoveSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, void>> call(RemoveScheduleParams params) async {
    final savedSchedulesOrFailure = await repository.getSavedSchedules();

    return savedSchedulesOrFailure.fold((failure) => Left(failure), (savedSchedules) async {
      for (final savedSchedule in savedSchedules) {
        if (savedSchedule.query == params.query) {
          savedSchedules.remove(savedSchedule);
          break;
        }
      }

      await (params.isGroup
          ? repository.removeGroupSchedule(params.query)
          : repository.removeEmployeeSchedule(params.query));

      await repository.setSavedSchedules(savedSchedules);

      return Right(null);
    });
  }
}

class RemoveScheduleParams extends Equatable {
  const RemoveScheduleParams({required this.isGroup, required this.query});

  final bool isGroup;
  final String query;

  @override
  List<Object?> get props => [isGroup, query];
}
