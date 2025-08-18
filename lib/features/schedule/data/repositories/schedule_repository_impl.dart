import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_local_data_source.dart';
import '../datasources/schedule_remote_data_source.dart';
import '../mappers/mappers.dart';
import '../models/models.dart';

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
  Future<Either<Failure, void>> loadGroupSchedule(String groupNumber) {
    return _updateSchedule(true, groupNumber);
  }

  @override
  Future<Either<Failure, Schedule>> updateGroupSchedule(String groupNumber) {
    return _updateSchedule(true, groupNumber);
  }

  @override
  Future<Either<Failure, void>> removeGroupSchedule(String groupNumber) async {
    try {
      return Right(await localDataSource.removeGroupSchedule(groupNumber));
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Schedule>> getEmployeeSchedule(String urlId) {
    return _getSchedule(false, urlId);
  }

  @override
  Future<Either<Failure, void>> loadEmployeeSchedule(String urlId) {
    return _updateSchedule(false, urlId);
  }

  @override
  Future<Either<Failure, Schedule>> updateEmployeeSchedule(String urlId) {
    return _updateSchedule(false, urlId);
  }

  @override
  Future<Either<Failure, void>> removeEmployeeSchedule(String urlId) async {
    try {
      return Right(await localDataSource.removeEmployeeSchedule(urlId));
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, Schedule>> _getSchedule(bool isGroup, String query) async {
    final List<GroupModel> groups;
    final List<FacultyModel> faculties;
    final List<SpecialityModel> specialities;
    final ScheduleModel schedule;

    try {
      groups = await localDataSource.getGroups();
      faculties = await localDataSource.getFaculties();
      specialities = await localDataSource.getSpecialities();

      schedule = await (isGroup
          ? localDataSource.getGroupSchedule(query)
          : localDataSource.getEmployeeSchedule(query));
    } catch (_) {
      return _updateSchedule(isGroup, query);
    }

    return _getPreparedSchedule(isGroup, groups, faculties, specialities, schedule);
  }

  Future<Either<Failure, Schedule>> _updateSchedule(bool isGroup, String query) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final groupList = await remoteDataSource.getGroups();
      final facultyMap = await remoteDataSource.getFaculties();
      final specialityMap = await remoteDataSource.getSpecialities();

      final schedule = await (isGroup
          ? remoteDataSource.getGroupSchedule(query)
          : remoteDataSource.getEmployeeSchedule(query));

      await localDataSource.setGroups(groupList);
      await localDataSource.setFaculties(facultyMap);
      await localDataSource.setSpecialities(specialityMap);

      await (isGroup
          ? localDataSource.setGroupSchedule(schedule)
          : localDataSource.setGroupSchedule(schedule));

      return _getPreparedSchedule(isGroup, groupList, facultyMap, specialityMap, schedule);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Schedule>> _getPreparedSchedule(
    bool isGroup,
    List<GroupModel> groups,
    List<FacultyModel> faculties,
    List<SpecialityModel> specialities,
    ScheduleModel schedule,
  ) async {
    final facultyMap = _getFacultyMap(faculties);
    final specialityMap = _getSpecialityMap(specialities);

    final groupMap = <String, Group>{};
    for (final group in groups) {
      groupMap[group.name!] = GroupMapper.toEntity(
        group: group,
        faculty: facultyMap[group.facultyId!]!,
        speciality: specialityMap[group.specialityDepartmentEducationFormId!]!,
      );
    }

    return Right(
      isGroup
          ? ScheduleMapper.toGroupSchedule(schedule: schedule, groupMap: groupMap)
          : ScheduleMapper.toEmployeeSchedule(schedule: schedule, groupMap: groupMap),
    );
  }

  @override
  Future<Either<Failure, List<Group>>> getGroups() async {
    final List<GroupModel> groups;
    final List<FacultyModel> faculties;
    final List<SpecialityModel> specialities;

    try {
      groups = await localDataSource.getGroups();
      faculties = await localDataSource.getFaculties();
      specialities = await localDataSource.getSpecialities();
    } catch (_) {
      return updateGroups();
    }

    return _getPreparedGroupList(groups, faculties, specialities);
  }

  @override
  Future<Either<Failure, List<Group>>> updateGroups() async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final groups = await remoteDataSource.getGroups();
      final faculties = await remoteDataSource.getFaculties();
      final specialities = await remoteDataSource.getSpecialities();

      await localDataSource.setGroups(groups);
      await localDataSource.setFaculties(faculties);
      await localDataSource.setSpecialities(specialities);

      return _getPreparedGroupList(groups, faculties, specialities);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Group>>> _getPreparedGroupList(
    List<GroupModel> groups,
    List<FacultyModel> faculties,
    List<SpecialityModel> specialities,
  ) async {
    final facultyMap = _getFacultyMap(faculties);
    final specialityMap = _getSpecialityMap(specialities);

    final preparedGroupList = <Group>[];
    for (final group in groups) {
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
  Future<Either<Failure, List<Employee>>> getEmployees() async {
    final List<EmployeeModel> employeeList;

    try {
      employeeList = await localDataSource.getEmployees();
    } catch (_) {
      return updateEmployees();
    }

    return _getPreparedEmployeeList(employeeList);
  }

  @override
  Future<Either<Failure, List<Employee>>> updateEmployees() async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure());
    }
    try {
      final employeeList = await remoteDataSource.getEmployees();

      await localDataSource.setEmployees(employeeList);

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

  Map<int, FacultyModel> _getFacultyMap(List<FacultyModel> faculties) {
    final Map<int, FacultyModel> facultyMap = {};
    for (final faculty in faculties) {
      facultyMap[faculty.id!] = faculty;
    }
    return facultyMap;
  }

  Map<int, SpecialityModel> _getSpecialityMap(List<SpecialityModel> specialities) {
    final Map<int, SpecialityModel> specialityMap = {};
    for (final speciality in specialities) {
      specialityMap[speciality.id!] = speciality;
    }
    return specialityMap;
  }

  @override
  Future<Either<Failure, ScheduleLastUpdate>> getGroupScheduleLastUpdate(String groupNumber) {
    return _getScheduleLastUpdate(true, groupNumber);
  }

  @override
  Future<Either<Failure, ScheduleLastUpdate>> getEmployeeScheduleLastUpdate(String urlId) {
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

      return Right(ScheduleLastUpdateMapper.toEntity(scheduleLastUpdate: scheduleLastUpdate));
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

        await localDataSource.setCurrentWeek(currentWeek);
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
  Future<Either<Failure, List<SavedSchedule>>> getSavedSchedules() async {
    try {
      final savedScheduleList = await localDataSource.getSavedSchedules();

      return Right(
        savedScheduleList
            .map((savedSchedule) => SavedScheduleMapper.toEntity(savedSchedule: savedSchedule))
            .toList(),
      );
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setSavedSchedules(List<SavedSchedule> savedSchedules) async {
    try {
      await localDataSource.setSavedSchedules(
        savedSchedules
            .map((savedSchedule) => SavedScheduleMapper.toModel(savedSchedule: savedSchedule))
            .toList(),
      );

      return Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
