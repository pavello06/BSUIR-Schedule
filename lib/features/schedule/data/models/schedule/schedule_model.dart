import '../group/group_model.dart';
import '../subject/subject_employee_model.dart';
import '../subject/subject_model.dart';
import 'exam_filter_model.dart';
import 'lesson_filter_model.dart';

class ScheduleModel {
  ScheduleModel({
    required this.startDate,
    required this.endDate,
    required this.startExamsDate,
    required this.endExamsDate,
    required this.employeeDto,
    required this.studentGroupDto,
    required this.schedules,
    this.previousSchedules,
    this.currentTerm,
    this.previousTerm,
    required this.exams,
    this.currentPeriod,
    required this.title,
    required this.lessonFilter,
    required this.examFilter,
  });

  final String startDate;
  final String endDate;
  final String? startExamsDate;
  final String? endExamsDate;
  final SubjectEmployeeModel? employeeDto;
  final GroupModel? studentGroupDto;
  final Map<String, List<SubjectModel>> schedules;
  final Map<String, List<SubjectModel>>? previousSchedules;
  final String? currentTerm;
  final String? previousTerm;
  final List<SubjectModel> exams;
  final String? currentPeriod;
  final String? title;
  final LessonFilterModel? lessonFilter;
  final ExamFilterModel? examFilter;

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
      exams: List<SubjectModel>.from(json['exams'].map((x) => SubjectModel.fromJson(x))),
      currentPeriod: json['currentPeriod'],
      title: json['title'],
      lessonFilter: json['lessonFilter'],
      examFilter: json['examFilter'],
    );
  }

  Map<String, dynamic> toJson() => {
    'startDate': startDate,
    'endDate': endDate,
    'startExamsDate': startExamsDate,
    'endExamsDate': endExamsDate,
    'employeeDto': employeeDto?.toJson(),
    'studentGroupDto': studentGroupDto?.toJson(),
    'schedules': Map.from(
      schedules,
    ).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x.toJson()).toList())),
    'previousSchedules': previousSchedules == null
        ? null
        : Map.from(
            previousSchedules!,
          ).map((k, v) => MapEntry<String, dynamic>(k, v.map((x) => x.toJson()).toList())),
    'currentTerm': currentTerm,
    'previousTerm': previousTerm,
    'exams': exams.map((x) => x.toJson()).toList(),
    'currentPeriod': currentPeriod,
    'title': title,
    'lessonFilter': lessonFilter,
    'examFilter': examFilter,
  };
}
