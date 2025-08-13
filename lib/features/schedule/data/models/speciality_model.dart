import 'education_form_model.dart';

class SpecialityModel {
  SpecialityModel({
    required this.id,
    required this.name,
    required this.abbrev,
    required this.educationForm,
    required this.facultyId,
    required this.code,
  });

  final int id;
  final String name;
  final String abbrev;
  final EducationFormModel educationForm;
  final int facultyId;
  final String code;

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    return SpecialityModel(
      id: json['id'],
      name: json['name'],
      abbrev: json['abbrev'],
      educationForm: EducationFormModel.fromJson(json['educationForm']),
      facultyId: json['facultyId'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'abbrev': abbrev,
    'educationForm': educationForm.toJson(),
    'facultyId': facultyId,
    'code': code,
  };
}
