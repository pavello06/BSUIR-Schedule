import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  const Employee({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.degreeAbbrev,
    required this.rank,
    required this.photoLink,
    required this.academicDepartment,
    required this.urlId,
    required this.email,
  });

  final String firstName;
  final String lastName;
  final String? middleName;
  final String degreeAbbrev;
  final String? rank;
  final String photoLink;
  final List<String>? academicDepartment;
  final String urlId;
  final String? email;

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    middleName,
    degreeAbbrev,
    rank,
    photoLink,
    academicDepartment,
    urlId,
    email,
  ];
}
