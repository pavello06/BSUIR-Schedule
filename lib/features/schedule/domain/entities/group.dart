import 'package:equatable/equatable.dart';

import 'faculty.dart';
import 'speciality.dart';

class Group extends Equatable {
  const Group({
    required this.name,
    required this.faculty,
    required this.speciality,
    required this.course,
    required this.numberOfStudents,
  });

  final String name;
  final Faculty faculty;
  final Speciality speciality;
  final int course;
  final int? numberOfStudents;

  @override
  List<Object?> get props => [
    name,
    faculty,
    speciality,
    course,
    numberOfStudents,
  ];
}
