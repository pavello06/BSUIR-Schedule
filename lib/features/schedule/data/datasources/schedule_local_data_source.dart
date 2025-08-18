import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/models.dart';

const _pathToGroupSchedule = 'groupSchedule';
const _pathToEmployeeSchedule = 'employeeSchedule';
const _pathToGroups = 'groups';
const _pathToEmployees = 'employees';
const _pathToFaculties = 'faculties';
const _pathToSpecialities = 'specialities';
const _pathToCurrentWeek = 'currentWeek';
const _pathToSavedSchedules = 'savedSchedules';

abstract class ScheduleLocalDataSource {
  Future<ScheduleModel> getGroupSchedule(String groupNumber);

  Future<void> setGroupSchedule(ScheduleModel schedule);

  Future<void> removeGroupSchedule(String groupNumber);

  Future<ScheduleModel> getEmployeeSchedule(String urlId);

  Future<void> setEmployeeSchedule(ScheduleModel schedule);

  Future<void> removeEmployeeSchedule(String urlId);

  Future<List<GroupModel>> getGroups();

  Future<void> setGroups(List<GroupModel> groups);

  Future<List<EmployeeModel>> getEmployees();

  Future<void> setEmployees(List<EmployeeModel> employees);

  Future<List<FacultyModel>> getFaculties();

  Future<void> setFaculties(List<FacultyModel> faculties);

  Future<List<SpecialityModel>> getSpecialities();

  Future<void> setSpecialities(List<SpecialityModel> specialities);

  Future<CurrentWeekModel> getCurrentWeek();

  Future<void> setCurrentWeek(CurrentWeekModel currentWeek);

  Future<List<SavedScheduleModel>> getSavedSchedules();

  Future<void> setSavedSchedules(List<SavedScheduleModel> savedSchedules);
}

class ScheduleLocalDataSourceImpl extends ScheduleLocalDataSource {
  ScheduleLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  @override
  Future<ScheduleModel> getGroupSchedule(String groupNumber) async {
    return await _getSchedule(true, groupNumber);
  }

  @override
  Future<void> setGroupSchedule(ScheduleModel schedule) async {
    await sharedPreferences.setString(
      '$_pathToGroupSchedule${schedule.studentGroupDto!.name}',
      json.encode(schedule.toJson()),
    );
  }

  @override
  Future<void> removeGroupSchedule(String groupNumber) async {
    await sharedPreferences.remove('$_pathToGroupSchedule$groupNumber');
  }

  @override
  Future<ScheduleModel> getEmployeeSchedule(String urlId) async {
    return await _getSchedule(false, urlId);
  }

  @override
  Future<void> setEmployeeSchedule(ScheduleModel schedule) async {
    await sharedPreferences.setString(
      '$_pathToEmployeeSchedule${schedule.employeeDto!.urlId}',
      json.encode(schedule.toJson()),
    );
  }

  @override
  Future<void> removeEmployeeSchedule(String urlId) async {
    await sharedPreferences.remove('$_pathToEmployeeSchedule$urlId');
  }

  Future<ScheduleModel> _getSchedule(bool isGroup, String query) async {
    final response = await sharedPreferences.getString(
      '${isGroup ? _pathToGroupSchedule : _pathToEmployeeSchedule}$query',
    );
    if (response == null) {
      throw CacheException();
    }
    final schedule = json.decode(response);

    return ScheduleModel.fromJson(schedule);
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    final response = await sharedPreferences.getStringList(_pathToGroups);
    if (response == null) {
      throw CacheException();
    }

    return (response as List).map((group) => GroupModel.fromJson(json.decode(group))).toList();
  }

  @override
  Future<void> setGroups(List<GroupModel> groups) async {
    await sharedPreferences.setStringList(
      _pathToGroups,
      groups.map((group) => json.encode(group.toJson())).toList(),
    );
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final response = await sharedPreferences.getStringList(_pathToEmployees);
    if (response == null) {
      throw CacheException();
    }

    return (response as List)
        .map((employee) => EmployeeModel.fromJson(json.decode(employee)))
        .toList();
  }

  @override
  Future<void> setEmployees(List<EmployeeModel> employees) async {
    await sharedPreferences.setStringList(
      _pathToEmployees,
      employees.map((employee) => json.encode(employee.toJson())).toList(),
    );
  }

  @override
  Future<List<FacultyModel>> getFaculties() async {
    final response = await sharedPreferences.getStringList(_pathToFaculties);
    if (response == null) {
      throw CacheException();
    }

    return (response as List)
        .map((faculty) => FacultyModel.fromJson(json.decode(faculty)))
        .toList();
  }

  @override
  Future<void> setFaculties(List<FacultyModel> faculties) {
    return sharedPreferences.setStringList(
      _pathToFaculties,
      faculties.map((faculty) => json.encode(faculty.toJson())).toList(),
    );
  }

  @override
  Future<List<SpecialityModel>> getSpecialities() async {
    final response = await sharedPreferences.getStringList(_pathToSpecialities);
    if (response == null) {
      throw CacheException();
    }

    return (response as List)
        .map((speciality) => SpecialityModel.fromJson(json.decode(speciality)))
        .toList();
  }

  @override
  Future<void> setSpecialities(List<SpecialityModel> specialities) async {
    await sharedPreferences.setStringList(
      _pathToSpecialities,
      specialities.map((speciality) => json.encode(speciality.toJson())).toList(),
    );
  }

  @override
  Future<CurrentWeekModel> getCurrentWeek() async {
    final response = await sharedPreferences.getString(_pathToCurrentWeek);
    if (response == null) {
      throw CacheException();
    }
    final currentWeek = json.decode(response);

    return CurrentWeekModel.fromJson(currentWeek);
  }

  @override
  Future<void> setCurrentWeek(CurrentWeekModel currentWeek) async {
    await sharedPreferences.setString(_pathToCurrentWeek, json.encode(currentWeek.toJson()));
  }

  @override
  Future<List<SavedScheduleModel>> getSavedSchedules() async {
    final response = await sharedPreferences.getStringList(_pathToSavedSchedules);
    if (response == null) {
      return <SavedScheduleModel>[];
    }

    return (response as List)
        .map((savedSchedule) => SavedScheduleModel.fromJson(json.decode(savedSchedule)))
        .toList();
  }

  @override
  Future<void> setSavedSchedules(List<SavedScheduleModel> savedSchedules) async {
    await sharedPreferences.setStringList(
      _pathToSavedSchedules,
      savedSchedules.map((savedSchedule) => json.encode(savedSchedule.toJson())).toList(),
    );
  }
}
