class EmployeeModel {
  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.degree,
    required this.rank,
    required this.photoLink,
    this.calendarId,
    required this.academicDepartment,
    this.id,
    required this.urlId,
    this.fio,
  });

  final String firstName;
  final String lastName;
  final String? middleName;
  final String degree;
  final String? rank;
  final String photoLink;
  final String? calendarId;
  final List<String> academicDepartment;
  final int? id;
  final String urlId;
  final String? fio;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      degree: json['degree'],
      rank: json['rank'],
      photoLink: json['photoLink'],
      calendarId: json['calendarId'],
      academicDepartment: List<String>.from(json['academicDepartment']),
      id: json['id'],
      urlId: json['urlId'],
      fio: json['fio'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'middleName': middleName,
    'degree': degree,
    'rank': rank,
    'photoLink': photoLink,
    'calendarId': calendarId,
    'academicDepartment': academicDepartment,
    'id': id,
    'urlId': urlId,
    'fio': fio,
  };
}
