import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee/employee.dart';
import '../repositories/schedule_repository.dart';

class UpdateEmployees extends UseCase<List<Employee>, NoParams> {
  UpdateEmployees({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Employee>>> call(NoParams params) async {
    return await repository.updateEmployees();
  }
}
