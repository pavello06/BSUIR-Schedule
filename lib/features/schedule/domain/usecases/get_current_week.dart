import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/current_week.dart';
import '../repositories/schedule_repository.dart';

class GetCurrentWeek extends UseCase<CurrentWeek, NoParams> {
  GetCurrentWeek({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, CurrentWeek>> call(NoParams params) async {
    return await repository.getCurrentWeek();
  }
}
