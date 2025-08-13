import 'subject_employee_model.dart';
import 'subject_model.dart';
import 'group_model.dart';

class ScheduleModel {
  ScheduleModel({
    required this.startDate,
    required this.endDate,
    required this.startExamsDate,
    required this.endExamsDate,
    required this.employeeDto,
    required this.studentGroupDto,
    required this.schedules,
    required this.previousSchedules,
    required this.currentTerm,
    required this.previousTerm,
    required this.exams,
    required this.currentPeriod,
  });

  final String startDate;
  final String endDate;
  final String? startExamsDate;
  final String? endExamsDate;
  final SubjectEmployeeModel? employeeDto;
  final GroupModel? studentGroupDto;
  final Map<String, List<SubjectModel>> schedules;
  final Map<String, List<SubjectModel>>? previousSchedules;
  final String currentTerm;
  final String? previousTerm;
  final List<SubjectModel> exams;
  final String currentPeriod;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      startDate: json['startDate'],
      endDate: json['endDate'],
      startExamsDate: json['startExamsDate'],
      endExamsDate: json['endExamsDate'],
      employeeDto: json['employeeDto'] == null
          ? null
          : SubjectEmployeeModel.fromJson(json['employeeDto']),
      studentGroupDto: json['studentGroupDto'] == null
          ? null
          : GroupModel.fromJson(json['studentGroupDto']),
      schedules: Map.from(json['schedules']).map(
        (k, v) => MapEntry<String, List<SubjectModel>>(
          k.toString(),
          List<SubjectModel>.from(v.map((x) => SubjectModel.fromJson(x))),
        ),
      ),
      previousSchedules: json['previousSchedules'] == null
          ? null
          : Map.from(json['previousSchedules']).map(
              (k, v) => MapEntry<String, List<SubjectModel>>(
                k.toString(),
                List<SubjectModel>.from(v.map((x) => SubjectModel.fromJson(x))),
              ),
            ),
      currentTerm: json['currentTerm'],
      previousTerm: json['previousTerm'],
      exams: List<SubjectModel>.from(
        json['exams']!.map((x) => SubjectModel.fromJson(x)),
      ),
      currentPeriod: json['currentPeriod'],
    );
  }

  Map<String, dynamic> toJson() => {
    'startDate': startDate,
    'endDate': endDate,
    'startExamsDate': startExamsDate,
    'endExamsDate': endExamsDate,
    'employeeDto': employeeDto?.toJson(),
    'studentGroupDto': studentGroupDto?.toJson(),
    'schedules': Map.from(schedules).map(
      (k, v) => MapEntry<String, dynamic>(k, v.map((x) => x.toJson()).toList()),
    ),
    'previousSchedules': previousSchedules == null
        ? null
        : Map.from(previousSchedules!).map(
            (k, v) =>
                MapEntry<String, dynamic>(k, v.map((x) => x.toJson()).toList()),
          ),
    'currentTerm': currentTerm,
    'previousTerm': previousTerm,
    'exams': exams.map((x) => x.toJson()).toList(),
    'currentPeriod': currentPeriod,
  };
}
