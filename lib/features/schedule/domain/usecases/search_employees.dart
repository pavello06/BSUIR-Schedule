import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/schedule_repository.dart';

class SearchEmployees extends UseCase<List<Employee>, SearchEmployeesParams> {
  SearchEmployees({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Employee>>> call(SearchEmployeesParams params) async {
    return Right(
      params.employeeList
          .where(
            (employee) =>
                '${employee.lastName} ${employee.firstName} ${employee.middleName ?? ''} ${employee.degreeAbbrev} ${employee.rank ?? ''} ${employee.academicDepartment?.join(', ')}'
                    .toLowerCase()
                    .contains(params.query.toLowerCase()),
          )
          .toList(),
    );
  }
}

class SearchEmployeesParams extends Equatable {
  const SearchEmployeesParams({
    required this.employeeList,
    required this.query,
    required this.words,
  });

  final List<Employee> employeeList;
  final String query;
  final Map<String, String> words;

  @override
  List<Object?> get props => [employeeList, query, words];
}
