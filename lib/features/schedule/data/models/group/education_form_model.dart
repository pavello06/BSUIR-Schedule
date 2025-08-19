class EducationFormModel {
  EducationFormModel({this.id, required this.name});

  final int? id;
  final String name;

  factory EducationFormModel.fromJson(Map<String, dynamic> json) {
    return EducationFormModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
