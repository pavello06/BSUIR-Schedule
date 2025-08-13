import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/current_week_model.dart';
import '../models/employee_model.dart';
import '../models/faculty_model.dart';
import '../models/schedule_last_update_model.dart';
import '../models/schedule_model.dart';
import '../models/speciality_model.dart';
import '../models/group_model.dart';

const _url = 'https://iis.bsuir.by/api/v1/';
const _headers = {'Content-Type': 'application/json'};

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel> getGroupSchedule(String groupNumber);

  Future<ScheduleModel> getEmployeeSchedule(String urlId);

  Future<List<GroupModel>> getGroupList();

  Future<List<EmployeeModel>> getEmployeeList();

  Future<Map<int, FacultyModel>> getFacultyMap();

  Future<Map<int, SpecialityModel>> getSpecialityMap();

  Future<ScheduleLastUpdateModel> getGroupScheduleLastUpdate(
    String groupNumber,
  );

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
    final response = await client.get(
      Uri.parse(
        '$_url${isGroup ? 'schedule?studentGroup=' : 'employees/schedule/'}$query',
      ),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final schedule = json.decode(response.body);

      return ScheduleModel.fromJson(schedule);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GroupModel>> getGroupList() async {
    final response = await client.get(
      Uri.parse('${_url}student-groups'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final groupList = json.decode(response.body);

      return (groupList as List)
          .map((group) => GroupModel.fromJson(group))
          .where((group) => group.course != null)
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployeeList() async {
    final response = await client.get(
      Uri.parse('${_url}employees/all'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final employeeList = json.decode(response.body);

      return (employeeList as List)
          .map((employee) => EmployeeModel.fromJson(employee))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<int, FacultyModel>> getFacultyMap() async {
    final response = await client.get(
      Uri.parse('${_url}faculties'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final facultyList = json.decode(response.body);
      final Map<int, FacultyModel> facultyMap = {};
      for (final faculty in facultyList) {
        final decodedFaculty = FacultyModel.fromJson(faculty);
        facultyMap[decodedFaculty.id] = decodedFaculty;
      }

      return facultyMap;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<int, SpecialityModel>> getSpecialityMap() async {
    final response = await client.get(
      Uri.parse('${_url}specialities'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final specialityList = json.decode(response.body);
      final Map<int, SpecialityModel> specialityMap = {};
      for (final speciality in specialityList) {
        final decodedSpeciality = SpecialityModel.fromJson(speciality);
        specialityMap[decodedSpeciality.id] = decodedSpeciality;
      }

      return specialityMap;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ScheduleLastUpdateModel> getGroupScheduleLastUpdate(
    String groupNumber,
  ) {
    return _getScheduleLastUpdate(true, groupNumber);
  }

  @override
  Future<ScheduleLastUpdateModel> getEmployeeScheduleLastUpdate(String urlId) {
    return _getScheduleLastUpdate(false, urlId);
  }

  Future<ScheduleLastUpdateModel> _getScheduleLastUpdate(
    bool isGroup,
    String query,
  ) async {
    final response = await client.get(
      Uri.parse(
        '${_url}last-update-date/${isGroup ? 'student-group?groupNumber=' : 'employee?url-id='}$query',
      ),
      headers: _headers,
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
    final response = await client.get(
      Uri.parse('${_url}schedule/current-week'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final currentWeek = json.decode(response.body);

      return CurrentWeekModel.fromJson({'week': currentWeek});
    } else {
      throw ServerException();
    }
  }
}
