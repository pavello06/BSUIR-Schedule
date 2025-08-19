import '../employee/employee_model.dart';
import '../group/faculty_model.dart';
import '../group/group_model.dart';
import '../group/speciality_model.dart';

class SavedScheduleModel {
  SavedScheduleModel({
    required this.title,
    required this.isGroup,
    required this.group,
    required this.faculty,
    required this.speciality,
    required this.employee,
    required this.query,
    required this.isActive,
  });

  final String? title;
  final bool isGroup;
  final GroupModel? group;
  final FacultyModel? faculty;
  final SpecialityModel? speciality;
  final EmployeeModel? employee;
  final String query;
  final bool isActive;

  factory SavedScheduleModel.fromJson(Map<String, dynamic> json) {
    return SavedScheduleModel(
      title: json['title'],
      isGroup: json['isGroup'],
      group: json['group'] == null ? null : GroupModel.fromJson(json['group']),
      faculty: json['faculty'] == null ? null : FacultyModel.fromJson(json['faculty']),
      speciality: json['speciality'] == null ? null : SpecialityModel.fromJson(json['speciality']),
      employee: json['employee'] == null ? null : EmployeeModel.fromJson(json['employee']),
      query: json['query'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'isGroup': isGroup,
    'group': group?.toJson(),
    'faculty': faculty?.toJson(),
    'speciality': speciality?.toJson(),
    'employee': employee?.toJson(),
    'query': query,
    'isActive': isActive,
  };
}
