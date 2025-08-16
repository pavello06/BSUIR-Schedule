import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/current_week_model.dart';
import '../models/employee_model.dart';
import '../models/faculty_model.dart';
import '../models/saved_schedule_model.dart';
import '../models/schedule_model.dart';
import '../models/speciality_model.dart';
import '../models/group_model.dart';

const _cachedGroupSchedule = 'cachedGroupSchedule';
const _cachedEmployeeSchedule = 'cachedEmployeeSchedule';
const _cachedGroupList = 'cachedGroupList';
const _cachedEmployeeList = 'cachedEmployeeList';
const _cachedFacultyList = 'cachedFacultyList';
const _cachedSpecialityList = 'cachedSpecialityList';
const _cachedCurrentWeek = 'cachedCurrentWeek';
const _cachedSavedScheduleList = 'cachedSavedScheduleList';

abstract class ScheduleLocalDataSource {
  Future<ScheduleModel> getGroupSchedule(String groupNumber);

  Future<void> cachedGroupSchedule(ScheduleModel schedule);

  Future<ScheduleModel> getEmployeeSchedule(String urlId);

  Future<void> cachedEmployeeSchedule(ScheduleModel schedule);

  Future<List<GroupModel>> getGroupList();

  Future<void> cachedGroupList(List<GroupModel> groupList);

  Future<List<EmployeeModel>> getEmployeeList();

  Future<void> cachedEmployeeList(List<EmployeeModel> employeeList);

  Future<Map<int, FacultyModel>> getFacultyMap();

  Future<void> cachedFacultyMap(Map<int, FacultyModel> facultyMap);

  Future<Map<int, SpecialityModel>> getSpecialityMap();

  Future<void> cachedSpecialityMap(Map<int, SpecialityModel> specialityMap);

  Future<CurrentWeekModel> getCurrentWeek();

  Future<void> cachedCurrentWeek(CurrentWeekModel currentWeek);

  Future<List<SavedScheduleModel>> getSavedScheduleList();
}

class ScheduleLocalDataSourceImpl extends ScheduleLocalDataSource {
  ScheduleLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  @override
  Future<ScheduleModel> getGroupSchedule(String groupNumber) async {
    return await _getSchedule(true, groupNumber);
  }

  @override
  Future<void> cachedGroupSchedule(ScheduleModel schedule) async {
    await sharedPreferences.setString(
      '$_cachedGroupSchedule${schedule.studentGroupDto!.name}',
      json.encode(schedule.toJson()),
    );
  }

  @override
  Future<ScheduleModel> getEmployeeSchedule(String urlId) async {
    return await _getSchedule(false, urlId);
  }

  @override
  Future<void> cachedEmployeeSchedule(ScheduleModel schedule) async {
    await sharedPreferences.setString(
      '$_cachedEmployeeSchedule${schedule.employeeDto!.urlId}',
      json.encode(schedule.toJson()),
    );
  }

  Future<ScheduleModel> _getSchedule(bool isGroup, String query) async {
    final response = await sharedPreferences.getString(
      '${isGroup ? _cachedGroupSchedule : _cachedEmployeeSchedule}$query',
    );
    if (response == null) {
      throw CacheException();
    }
    final schedule = json.decode(response);

    return ScheduleModel.fromJson(schedule);
  }

  @override
  Future<List<GroupModel>> getGroupList() async {
    final response = await sharedPreferences.getStringList(_cachedGroupList);
    if (response == null) {
      throw CacheException();
    }

    return (response as List)
        .map((group) => GroupModel.fromJson(json.decode(group)))
        .toList();
  }

  @override
  Future<void> cachedGroupList(List<GroupModel> groupList) async {
    await sharedPreferences.setStringList(
      _cachedGroupList,
      groupList.map((group) => json.encode(group.toJson())).toList(),
    );
  }

  @override
  Future<List<EmployeeModel>> getEmployeeList() async {
    final response = await sharedPreferences.getStringList(_cachedEmployeeList);
    if (response == null) {
      throw CacheException();
    }

    return (response as List)
        .map((employee) => EmployeeModel.fromJson(json.decode(employee)))
        .toList();
  }

  @override
  Future<void> cachedEmployeeList(List<EmployeeModel> employeeList) async {
    await sharedPreferences.setStringList(
      _cachedEmployeeList,
      employeeList.map((employee) => json.encode(employee.toJson())).toList(),
    );
  }

  @override
  Future<Map<int, FacultyModel>> getFacultyMap() async {
    final response = await sharedPreferences.getStringList(_cachedFacultyList);
    if (response == null) {
      throw CacheException();
    }
    final facultyMap = <int, FacultyModel>{};
    for (final faculty in response) {
      final decodedFaculty = FacultyModel.fromJson(json.decode(faculty));
      facultyMap[decodedFaculty.id] = decodedFaculty;
    }

    return facultyMap;
  }

  @override
  Future<void> cachedFacultyMap(Map<int, FacultyModel> facultyMap) {
    return sharedPreferences.setStringList(
      _cachedFacultyList,
      facultyMap.values
          .map((faculty) => json.encode(faculty.toJson()))
          .toList(),
    );
  }

  @override
  Future<Map<int, SpecialityModel>> getSpecialityMap() async {
    final response = await sharedPreferences.getStringList(
      _cachedSpecialityList,
    );
    if (response == null) {
      throw CacheException();
    }
    final specialityMap = <int, SpecialityModel>{};
    for (final speciality in response) {
      final decodedSpeciality = SpecialityModel.fromJson(
        json.decode(speciality),
      );
      specialityMap[decodedSpeciality.id] = decodedSpeciality;
    }

    return specialityMap;
  }

  @override
  Future<void> cachedSpecialityMap(
    Map<int, SpecialityModel> specialityMap,
  ) async {
    await sharedPreferences.setStringList(
      _cachedSpecialityList,
      specialityMap.values
          .map((speciality) => json.encode(speciality.toJson()))
          .toList(),
    );
  }

  @override
  Future<CurrentWeekModel> getCurrentWeek() async {
    final response = await sharedPreferences.getString(_cachedCurrentWeek);
    if (response != null) {
      throw CacheException();
    }
    final currentWeek = json.decode(response!);

    return CurrentWeekModel.fromJson(currentWeek);
  }

  @override
  Future<void> cachedCurrentWeek(CurrentWeekModel currentWeek) async {
    await sharedPreferences.setString(
      _cachedCurrentWeek,
      json.encode(currentWeek.toJson()),
    );
  }

  @override
  Future<List<SavedScheduleModel>> getSavedScheduleList() async {
    final response = await sharedPreferences.getStringList(
      _cachedSavedScheduleList,
    );
    if (response == null) {
      return <SavedScheduleModel>[];
    }

    return (response as List)
        .map(
          (savedSchedule) =>
              SavedScheduleModel.fromJson(json.decode(savedSchedule)),
        )
        .toList();
  }
}
