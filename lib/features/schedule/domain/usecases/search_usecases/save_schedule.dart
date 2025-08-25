import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/employee/employee.dart';
import '../../entities/group/group.dart';
import '../../entities/schedule/saved_schedule.dart';
import '../../repositories/schedule_repository.dart';

class SaveSchedule extends UseCase<void, SaveScheduleParams> {
  SaveSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, void>> call(SaveScheduleParams params) async {
    final savedSchedulesOrFailure = await repository.getSavedSchedules();

    return savedSchedulesOrFailure.fold((failure) => Left(failure), (savedSchedules) async {
      for (final savedSchedule in savedSchedules) {
        if (savedSchedule.query == params.query) {
          return Right(null);
        }
      }

      await (params.isGroup
          ? repository.setGroupSchedule(params.query)
          : repository.setEmployeeSchedule(params.query));

      savedSchedules.add(
        SavedSchedule(
          title: null,
          isGroup: params.isGroup,
          group: params.group,
          employee: params.employee,
          query: params.query,
          isActive: false,
        ),
      );
      await repository.setSavedSchedules(savedSchedules);

      return Right(null);
    });
  }
}

class SaveScheduleParams extends Equatable {
  const SaveScheduleParams({required this.isGroup, this.group, this.employee, required this.query});

  final bool isGroup;
  final Group? group;
  final Employee? employee;
  final String query;

  @override
  List<Object?> get props => [isGroup, group, employee, query];
}
