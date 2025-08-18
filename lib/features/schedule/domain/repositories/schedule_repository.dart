import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/entities.dart';


abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>> getGroupSchedule(String groupNumber);

  Future<Either<Failure, void>> loadGroupSchedule(String groupNumber);

  Future<Either<Failure, Schedule>> updateGroupSchedule(String groupNumber);

  Future<Either<Failure, void>> removeGroupSchedule(String groupNumber);

  Future<Either<Failure, Schedule>> getEmployeeSchedule(String urlId);

  Future<Either<Failure, void>> loadEmployeeSchedule(String urlId);

  Future<Either<Failure, Schedule>> updateEmployeeSchedule(String urlId);

  Future<Either<Failure, void>> removeEmployeeSchedule(String urlId);

  Future<Either<Failure, List<Group>>> getGroups();

  Future<Either<Failure, List<Group>>> updateGroups();

  Future<Either<Failure, List<Employee>>> getEmployees();

  Future<Either<Failure, List<Employee>>> updateEmployees();

  Future<Either<Failure, ScheduleLastUpdate>> getGroupScheduleLastUpdate(String groupNumber);

  Future<Either<Failure, ScheduleLastUpdate>> getEmployeeScheduleLastUpdate(String urlId);

  Future<Either<Failure, CurrentWeek>> getCurrentWeek();

  Future<Either<Failure, List<SavedSchedule>>> getSavedSchedules();

  Future<Either<Failure, void>> setSavedSchedules(List<SavedSchedule> savedSchedules);
}
