import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/schedule_repository.dart';

class GetEmployeeList extends UseCase<List<Employee>, NoParams> {
  GetEmployeeList({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Employee>>> call(NoParams params) async {
    return await repository.getEmployeeList();
  }
}
