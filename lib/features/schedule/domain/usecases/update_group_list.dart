import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/group.dart';
import '../repositories/schedule_repository.dart';

class UpdateGroupList extends UseCase<List<Group>, NoParams> {
  UpdateGroupList({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Group>>> call(NoParams params) async {
    return await repository.updateGroupList();
  }
}
