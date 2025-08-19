import '../subject/subject_employee_model.dart';
import '../subject/subject_group_model.dart';

class SubjectModel {
  SubjectModel({
    required this.auditories,
    required this.endLessonTime,
    required this.lessonTypeAbbrev,
    required this.note,
    required this.numSubgroup,
    required this.startLessonTime,
    required this.studentGroups,
    required this.subject,
    required this.subjectFullName,
    required this.weekNumber,
    required this.employees,
    required this.dateLesson,
    required this.startLessonDate,
    required this.endLessonDate,
    this.split,
    this.announcement,
  });

  final List<String>? auditories;
  final String endLessonTime;
  final String lessonTypeAbbrev;
  final String? note;
  final int numSubgroup;
  final String startLessonTime;
  final List<SubjectGroupModel> studentGroups;
  final String subject;
  final String subjectFullName;
  final List<int> weekNumber;
  final List<SubjectEmployeeModel>? employees;
  final String? dateLesson;
  final String? startLessonDate;
  final String? endLessonDate;
  final bool? split;
  final bool? announcement;

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      auditories: json['auditories'] == null ? null : List<String>.from(json['auditories']),
      endLessonTime: json['endLessonTime'],
      lessonTypeAbbrev: json['lessonTypeAbbrev'],
      note: json['note'],
      numSubgroup: json['numSubgroup'],
      startLessonTime: json['startLessonTime'],
      studentGroups: List<SubjectGroupModel>.from(
        json['studentGroups'].map((x) => SubjectGroupModel.fromJson(x)),
      ),
      subject: json['subject'],
      subjectFullName: json['subjectFullName'],
      weekNumber: List<int>.from(json['weekNumber']),
      employees: json['employees'] == null
          ? null
          : List<SubjectEmployeeModel>.from(
              json['employees'].map((x) => SubjectEmployeeModel.fromJson(x)),
            ),
      dateLesson: json['dateLesson'],
      startLessonDate: json['startLessonDate'],
      endLessonDate: json['endLessonDate'],
      split: json['split'],
      announcement: json['announcement'],
    );
  }

  Map<String, dynamic> toJson() => {
    'auditories': auditories,
    'endLessonTime': endLessonTime,
    'lessonTypeAbbrev': lessonTypeAbbrev,
    'note': note,
    'numSubgroup': numSubgroup,
    'startLessonTime': startLessonTime,
    'studentGroups': studentGroups.map((x) => x.toJson()).toList(),
    'subject': subject,
    'subjectFullName': subjectFullName,
    'weekNumber': weekNumber,
    'employees': employees?.map((x) => x.toJson()).toList(),
    'dateLesson': dateLesson,
    'startLessonDate': startLessonDate,
    'endLessonDate': endLessonDate,
    'split': split,
    'announcement': announcement,
  };
}
