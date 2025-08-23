import '../employee/employee_model.dart';
import '../group/faculty_model.dart';
import '../group/group_model.dart';
import '../group/speciality_model.dart';

class SavedScheduleModel {
  SavedScheduleModel({
    required this.isActive,
    required this.query,
    required this.isGroup,
    required this.group,
    required this.faculty,
    required this.speciality,
    required this.employee,
    required this.title,
  });

  final bool isActive;
  final String query;
  final bool isGroup;
  final GroupModel? group;
  final FacultyModel? faculty;
  final SpecialityModel? speciality;
  final EmployeeModel? employee;
  final String? title;

  factory SavedScheduleModel.fromJson(Map<String, dynamic> json) {
    return SavedScheduleModel(
      isActive: json['isActive'],
      query: json['query'],
      isGroup: json['isGroup'],
      group: json['group'] == null ? null : GroupModel.fromJson(json['group']),
      faculty: json['faculty'] == null ? null : FacultyModel.fromJson(json['faculty']),
      speciality: json['speciality'] == null ? null : SpecialityModel.fromJson(json['speciality']),
      employee: json['employee'] == null ? null : EmployeeModel.fromJson(json['employee']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'isActive': isActive,
    'query': query,
    'isGroup': isGroup,
    'group': group?.toJson(),
    'faculty': faculty?.toJson(),
    'speciality': speciality?.toJson(),
    'employee': employee?.toJson(),
    'title': title,
  };
}
