import 'package:bsuir_schedule/features/schedule/domain/entities/saved_schedule.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/current_week.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/schedule_last_update.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_local_data_source.dart';
import '../datasources/schedule_remote_data_source.dart';
import '../mappers/current_week_mapper.dart';
import '../mappers/employee_mapper.dart';
import '../mappers/saved_schedule_mapper.dart';
import '../mappers/schedule_last_update_mapper.dart';
import '../mappers/schedule_mapper.dart';
import '../mappers/group_mapper.dart';
import '../models/current_week_model.dart';
import '../models/employee_model.dart';
import '../models/faculty_model.dart';
import '../models/group_model.dart';
import '../models/schedule_model.dart';
import '../models/speciality_model.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  ScheduleRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final NetworkInfo networkInfo;
  final ScheduleRemoteDataSource remoteDataSource;
  final ScheduleLocalDataSource localDataSource;

  @override
  Future<Either<Failure, Schedule>> getGroupSchedule(String groupNumber) {
    return _getSchedule(true, groupNumber);
  }

  @override
  Future<Either<Failure, Schedule>> updateGroupSchedule(String groupNumber) {
    return _updateSchedule(true, groupNumber);
  }

  @override
  Future<Either<Failure, Schedule>> getEmployeeSchedule(String urlId) {
    return _getSchedule(false, urlId);
  }

  @override
  Future<Either<Failure, Schedule>> updateEmployeeSchedule(String urlId) {
    return _updateSchedule(false, urlId);
  }

  Future<Either<Failure, Schedule>> _getSchedule(
    bool isGroup,
    String query,
  ) async {
    final List<GroupModel> groupList;
    final Map<int, FacultyModel> facultyMap;
    final Map<int, SpecialityModel> specialityMap;
    final ScheduleModel schedule;

    try {
      groupList = await localDataSource.getGroupList();
      facultyMap = await localDataSource.getFacultyMap();
      specialityMap = await localDataSource.getSpecialityMap();

      schedule = await (isGroup
          ? localDataSource.getGroupSchedule(query)
          : localDataSource.getEmployeeSchedule(query));
    } catch (_) {
      return _updateSchedule(isGroup, query);
    }

    return _getPreparedSchedule(
      isGroup,
      groupList,
      facultyMap,
      specialityMap,
      schedule,
    );
  }

  Future<Either<Failure, Schedule>> _updateSchedule(
    bool isGroup,
    String query,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final groupList = await remoteDataSource.getGroupList();
      final facultyMap = await remoteDataSource.getFacultyMap();
      final specialityMap = await remoteDataSource.getSpecialityMap();

      final schedule = await (isGroup
          ? remoteDataSource.getGroupSchedule(query)
          : remoteDataSource.getEmployeeSchedule(query));

      await localDataSource.cachedGroupList(groupList);
      await localDataSource.cachedFacultyMap(facultyMap);
      await localDataSource.cachedSpecialityMap(specialityMap);

      await (isGroup
          ? localDataSource.cachedGroupSchedule(schedule)
          : localDataSource.cachedGroupSchedule(schedule));

      return _getPreparedSchedule(
        isGroup,
        groupList,
        facultyMap,
        specialityMap,
        schedule,
      );
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Schedule>> _getPreparedSchedule(
    bool isGroup,
    List<GroupModel> groupList,
    Map<int, FacultyModel> facultyMap,
    Map<int, SpecialityModel> specialityMap,
    ScheduleModel schedule,
  ) async {
    final groupMap = <String, Group>{};
    for (final group in groupList) {
      groupMap[group.name] = GroupMapper.toEntity(
        group: group,
        faculty: facultyMap[group.facultyId]!,
        speciality: specialityMap[group.specialityDepartmentEducationFormId]!,
      );
    }

    return Right(
      isGroup
          ? ScheduleMapper.toGroupSchedule(
              schedule: schedule,
              groupMap: groupMap,
            )
          : ScheduleMapper.toEmployeeSchedule(
              schedule: schedule,
              groupMap: groupMap,
            ),
    );
  }

  @override
  Future<Either<Failure, List<Group>>> getGroupList() async {
    final List<GroupModel> groupList;
    final Map<int, FacultyModel> facultyMap;
    final Map<int, SpecialityModel> specialityMap;

    try {
      groupList = await localDataSource.getGroupList();
      facultyMap = await localDataSource.getFacultyMap();
      specialityMap = await localDataSource.getSpecialityMap();
    } catch (_) {
      return updateGroupList();
    }

    return _getPreparedGroupList(groupList, facultyMap, specialityMap);
  }

  @override
  Future<Either<Failure, List<Group>>> updateGroupList() async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final groupList = await remoteDataSource.getGroupList();
      final facultyMap = await remoteDataSource.getFacultyMap();
      final specialityMap = await remoteDataSource.getSpecialityMap();

      await localDataSource.cachedGroupList(groupList);
      await localDataSource.cachedFacultyMap(facultyMap);
      await localDataSource.cachedSpecialityMap(specialityMap);

      return _getPreparedGroupList(groupList, facultyMap, specialityMap);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Group>>> _getPreparedGroupList(
    List<GroupModel> groupList,
    Map<int, FacultyModel> facultyMap,
    Map<int, SpecialityModel> specialityMap,
  ) async {
    final preparedGroupList = <Group>[];
    for (final group in groupList) {
      preparedGroupList.add(
        GroupMapper.toEntity(
          group: group,
          faculty: facultyMap[group.facultyId]!,
          speciality: specialityMap[group.specialityDepartmentEducationFormId]!,
        ),
      );
    }

    return Right(preparedGroupList);
  }

  @override
  Future<Either<Failure, List<Employee>>> getEmployeeList() async {
    final List<EmployeeModel> employeeList;

    try {
      employeeList = await localDataSource.getEmployeeList();
    } catch (_) {
      return updateEmployeeList();
    }

    return _getPreparedEmployeeList(employeeList);
  }

  @override
  Future<Either<Failure, List<Employee>>> updateEmployeeList() async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final employeeList = await remoteDataSource.getEmployeeList();

      await localDataSource.cachedEmployeeList(employeeList);

      return _getPreparedEmployeeList(employeeList);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Employee>>> _getPreparedEmployeeList(
    List<EmployeeModel> employeeList,
  ) async {
    final preparedEmployeeList = <Employee>[];
    for (final employee in employeeList) {
      preparedEmployeeList.add(EmployeeMapper.toEntity(employee: employee));
    }

    return Right(preparedEmployeeList);
  }

  @override
  Future<Either<Failure, ScheduleLastUpdate>> getGroupScheduleLastUpdate(
    String groupNumber,
  ) {
    return _getScheduleLastUpdate(true, groupNumber);
  }

  @override
  Future<Either<Failure, ScheduleLastUpdate>> getEmployeeScheduleLastUpdate(
    String urlId,
  ) {
    return _getScheduleLastUpdate(false, urlId);
  }

  Future<Either<Failure, ScheduleLastUpdate>> _getScheduleLastUpdate(
    bool isGroup,
    String query,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final scheduleLastUpdate = await (isGroup
          ? remoteDataSource.getGroupScheduleLastUpdate(query)
          : remoteDataSource.getEmployeeScheduleLastUpdate(query));

      return Right(
        ScheduleLastUpdateMapper.toEntity(
          scheduleLastUpdate: scheduleLastUpdate,
        ),
      );
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CurrentWeek>> getCurrentWeek() async {
    final CurrentWeekModel currentWeek;
    if (await networkInfo.isConnected) {
      try {
        currentWeek = await remoteDataSource.getCurrentWeek();

        await localDataSource.cachedCurrentWeek(currentWeek);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      try {
        currentWeek = await localDataSource.getCurrentWeek();
      } catch (_) {
        return Left(CacheFailure());
      }
    }

    return Right(CurrentWeekMapper.toEntity(currentWeek: currentWeek));
  }

  @override
  Future<Either<Failure, List<SavedSchedule>>> getSavedScheduleList() async {
    try {
      final savedScheduleList = await localDataSource.getSavedScheduleList();

      return Right(
        savedScheduleList
            .map(
              (savedSchedule) =>
                  SavedScheduleMapper.toEntity(savedSchedule: savedSchedule),
            )
            .toList(),
      );
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
