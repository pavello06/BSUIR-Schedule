class SubjectGroupModel {
  SubjectGroupModel({
    this.specialityName,
    this.specialityCode,
    required this.numberOfStudents,
    required this.name,
    this.educationDegree,
  });

  final String? specialityName;
  final String? specialityCode;
  final int numberOfStudents;
  final String name;
  final int? educationDegree;

  factory SubjectGroupModel.fromJson(Map<String, dynamic> json) {
    return SubjectGroupModel(
      specialityName: json['specialityName'],
      specialityCode: json['specialityCode'],
      numberOfStudents: json['numberOfStudents'],
      name: json['name'],
      educationDegree: json['educationDegree'],
    );
  }

  Map<String, dynamic> toJson() => {
    'specialityName': specialityName,
    'specialityCode': specialityCode,
    'numberOfStudents': numberOfStudents,
    'name': name,
    'educationDegree': educationDegree,
  };
}
