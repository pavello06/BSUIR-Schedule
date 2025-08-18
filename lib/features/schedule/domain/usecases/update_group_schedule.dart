import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class UpdateGroupSchedule extends UseCase<Schedule, UpdateGroupScheduleParams> {
  UpdateGroupSchedule({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, Schedule>> call(UpdateGroupScheduleParams params) async {
    return await repository.updateGroupSchedule(params.groupNumber);
  }
}

class UpdateGroupScheduleParams extends Equatable {
  const UpdateGroupScheduleParams({required this.groupNumber});

  final String groupNumber;

  @override
  List<Object?> get props => [groupNumber];
}
