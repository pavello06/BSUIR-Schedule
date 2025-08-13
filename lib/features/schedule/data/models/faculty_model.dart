class FacultyModel {
  FacultyModel({required this.name, required this.abbrev, required this.id});

  final String name;
  final String abbrev;
  final int id;

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      name: json['name'],
      abbrev: json['abbrev'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'abbrev': abbrev, 'id': id};
}
