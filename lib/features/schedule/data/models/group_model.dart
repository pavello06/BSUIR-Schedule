class GroupModel {
  GroupModel({
    required this.name,
    required this.facultyId,
    required this.facultyAbbrev,
    required this.facultyName,
    required this.specialityDepartmentEducationFormId,
    required this.specialityName,
    required this.specialityAbbrev,
    required this.course,
    required this.id,
    required this.calendarId,
    required this.educationDegree,
  });

  final String? name;
  final int? facultyId;
  final String? facultyAbbrev;
  final String? facultyName;
  final int? specialityDepartmentEducationFormId;
  final String? specialityName;
  final String? specialityAbbrev;
  final int? course;
  final int? id;
  final String? calendarId;
  final int? educationDegree;

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      facultyId: json['facultyId'],
      facultyAbbrev: json['facultyAbbrev'],
      facultyName: json['facultyName'],
      specialityDepartmentEducationFormId: json['specialityDepartmentEducationFormId'],
      specialityName: json['specialityName'],
      specialityAbbrev: json['specialityAbbrev'],
      course: json['course'],
      id: json['id'],
      calendarId: json['calendarId'],
      educationDegree: json['educationDegree'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'facultyId': facultyId,
    'facultyAbbrev': facultyAbbrev,
    'facultyName': facultyName,
    'specialityDepartmentEducationFormId': specialityDepartmentEducationFormId,
    'specialityName': specialityName,
    'specialityAbbrev': specialityAbbrev,
    'course': course,
    'id': id,
    'calendarId': calendarId,
    'educationDegree': educationDegree,
  };
}
