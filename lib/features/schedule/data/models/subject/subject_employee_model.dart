class SubjectEmployeeModel {
  SubjectEmployeeModel({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.photoLink,
    required this.degree,
    required this.degreeAbbrev,
    required this.rank,
    required this.email,
    required this.urlId,
    this.calendarId,
    this.jobPositions,
    this.chief,
  });

  final int? id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String photoLink;
  final String? degree;
  final String? degreeAbbrev;
  final String? rank;
  final String? email;
  final String urlId;
  final String? calendarId;
  final String? jobPositions;
  final bool? chief;

  factory SubjectEmployeeModel.fromJson(Map<String, dynamic> json) {
    return SubjectEmployeeModel(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      photoLink: json['photoLink'],
      degree: json['degree'],
      degreeAbbrev: json['degreeAbbrev'],
      rank: json['rank'],
      email: json['email'],
      urlId: json['urlId'],
      calendarId: json['calendarId'],
      jobPositions: json['jobPositions'],
      chief: json['chief'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'photoLink': photoLink,
    'degree': degree,
    'degreeAbbrev': degreeAbbrev,
    'rank': rank,
    'email': email,
    'urlId': urlId,
    'calendarId': calendarId,
    'jobPositions': jobPositions,
    'chief': chief,
  };
}
