import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class GetEmployeeSchedule extends UseCase<Schedule, GetEmployeeScheduleParams> {
  GetEmployeeSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, Schedule>> call(GetEmployeeScheduleParams params) async {
    return await repository.getEmployeeSchedule(params.urlId);
  }
}

class GetEmployeeScheduleParams extends Equatable {
  const GetEmployeeScheduleParams({required this.urlId});

  final String urlId;

  @override
  List<Object?> get props => [urlId];
}
