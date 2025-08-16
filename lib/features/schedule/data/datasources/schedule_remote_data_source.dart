import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/models.dart';

const _url = 'https://iis.bsuir.by/api/v1/';
const _headers = {'Content-Type': 'application/json'};

const _pathToGroupSchedule = 'schedule?studentGroup=';
const _pathToEmployeeSchedule = 'employees/schedule/';
const _pathToGroups = 'student-groups';
const _pathToEmployees = 'employees/all';
const _pathToFaculties = 'faculties';
const _pathToSpecialities = 'specialities';
const _pathToScheduleLastUpdate = 'last-update-date/';
const _pathToGroupScheduleLastUpdate = '${_pathToScheduleLastUpdate}student-group?groupNumber=';
const _pathToEmployeeScheduleLastUpdate = '${_pathToScheduleLastUpdate}employee?url-id=';
const _pathToCurrentWeek = 'schedule/current-week';

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel> getGroupSchedule(String groupNumber);

  Future<ScheduleModel> getEmployeeSchedule(String urlId);

  Future<List<GroupModel>> getGroups();

  Future<List<EmployeeModel>> getEmployees();

  Future<List<FacultyModel>> getFaculties();

  Future<List<SpecialityModel>> getSpecialities();

  Future<ScheduleLastUpdateModel> getGroupScheduleLastUpdate(String groupNumber);

  Future<ScheduleLastUpdateModel> getEmployeeScheduleLastUpdate(String urlId);

  Future<CurrentWeekModel> getCurrentWeek();
}

class ScheduleRemoteDataSourceImpl extends ScheduleRemoteDataSource {
  ScheduleRemoteDataSourceImpl({required this.client});

  final Client client;

  @override
  Future<ScheduleModel> getGroupSchedule(String groupNumber) async {
    return await _getSchedule(true, groupNumber);
  }

  @override
  Future<ScheduleModel> getEmployeeSchedule(String urlId) async {
    return await _getSchedule(false, urlId);
  }

  Future<ScheduleModel> _getSchedule(bool isGroup, String query) async {
    final response = await _getResponse(
      '${isGroup ? _pathToGroupSchedule : _pathToEmployeeSchedule}$query',
    );

    if (response.statusCode == 200) {
      final schedule = json.decode(response.body);

      return ScheduleModel.fromJson(schedule);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    final response = await _getResponse(_pathToGroups);

    if (response.statusCode == 200) {
      final groups = json.decode(response.body);

      return (groups as List)
          .map((group) => GroupModel.fromJson(group))
          .where((group) => group.course != null)
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final response = await _getResponse(_pathToEmployees);

    if (response.statusCode == 200) {
      final employees = json.decode(response.body);

      return (employees as List).map((employee) => EmployeeModel.fromJson(employee)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<FacultyModel>> getFaculties() async {
    final response = await _getResponse(_pathToFaculties);

    if (response.statusCode == 200) {
      final faculties = json.decode(response.body);

      return (faculties as List).map((faculty) => FacultyModel.fromJson(faculty)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SpecialityModel>> getSpecialities() async {
    final response = await _getResponse(_pathToSpecialities);

    if (response.statusCode == 200) {
      final specialities = json.decode(response.body);

      return (specialities as List)
          .map((speciality) => SpecialityModel.fromJson(speciality))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ScheduleLastUpdateModel> getGroupScheduleLastUpdate(String groupNumber) {
    return _getScheduleLastUpdate(true, groupNumber);
  }

  @override
  Future<ScheduleLastUpdateModel> getEmployeeScheduleLastUpdate(String urlId) {
    return _getScheduleLastUpdate(false, urlId);
  }

  Future<ScheduleLastUpdateModel> _getScheduleLastUpdate(bool isGroup, String query) async {
    final response = await _getResponse(
      '${isGroup ? _pathToGroupScheduleLastUpdate : _pathToEmployeeScheduleLastUpdate}$query',
    );

    if (response.statusCode == 200) {
      final scheduleLastUpdate = json.decode(response.body);

      return ScheduleLastUpdateModel.fromJson(scheduleLastUpdate);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CurrentWeekModel> getCurrentWeek() async {
    final response = await _getResponse(_pathToCurrentWeek);

    if (response.statusCode == 200) {
      final currentWeek = json.decode(response.body);

      return CurrentWeekModel.fromJson({'week': currentWeek});
    } else {
      throw ServerException();
    }
  }

  Future<Response> _getResponse(String path) async {
    return await client.get(Uri.parse('$_url$path'), headers: _headers);
  }
}
