import 'package:equatable/equatable.dart';

class Speciality extends Equatable {
  const Speciality({
    required this.id,
    required this.name,
    required this.abbrev,
    required this.educationFormName,
    required this.code,
  });

  final int id;
  final String name;
  final String abbrev;
  final String educationFormName;
  final String code;

  @override
  List<Object?> get props => [id, name, abbrev, educationFormName, code];
}
