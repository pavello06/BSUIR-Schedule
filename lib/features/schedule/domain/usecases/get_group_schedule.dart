import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class GetGroupSchedule extends UseCase<Schedule, GetGroupScheduleParams> {
  GetGroupSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, Schedule>> call(GetGroupScheduleParams params) async {
    return await repository.getGroupSchedule(params.groupNumber);
  }
}

class GetGroupScheduleParams extends Equatable {
  const GetGroupScheduleParams({required this.groupNumber});

  final String groupNumber;

  @override
  List<Object?> get props => [groupNumber];
}
