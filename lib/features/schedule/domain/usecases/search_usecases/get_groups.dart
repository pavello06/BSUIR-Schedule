import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/group/group.dart';
import '../../repositories/schedule_repository.dart';

class GetGroups extends UseCase<List<Group>, NoParams> {
  GetGroups({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Group>>> call(NoParams params) async {
    return await repository.getGroups();
  }
}
