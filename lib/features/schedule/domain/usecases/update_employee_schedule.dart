import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class UpdateEmployeeSchedule extends UseCase<Schedule, UpdateEmployeeScheduleParams> {
  UpdateEmployeeSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, Schedule>> call(UpdateEmployeeScheduleParams params) async {
    return await repository.updateEmployeeSchedule(params.urlId);
  }
}

class UpdateEmployeeScheduleParams extends Equatable {
  const UpdateEmployeeScheduleParams({required this.urlId});

  final String urlId;

  @override
  List<Object?> get props => [urlId];
}
