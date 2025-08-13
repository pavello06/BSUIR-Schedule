import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/current_week.dart';
import '../entities/employee.dart';
import '../entities/schedule.dart';
import '../entities/schedule_last_update.dart';
import '../entities/group.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, Schedule>> getGroupSchedule(String groupNumber);

  Future<Either<Failure, Schedule>> updateGroupSchedule(String groupNumber);

  Future<Either<Failure, Schedule>> getEmployeeSchedule(String urlId);

  Future<Either<Failure, Schedule>> updateEmployeeSchedule(String urlId);

  Future<Either<Failure, List<Group>>> getGroupList();

  Future<Either<Failure, List<Group>>> updateGroupList();

  Future<Either<Failure, List<Employee>>> getEmployeeList();

  Future<Either<Failure, List<Employee>>> updateEmployeeList();

  Future<Either<Failure, ScheduleLastUpdate>> getGroupScheduleLastUpdate(
    String groupNumber,
  );

  Future<Either<Failure, ScheduleLastUpdate>> getEmployeeScheduleLastUpdate(
    String urlId,
  );

  Future<Either<Failure, CurrentWeek>> getCurrentWeek();
}
