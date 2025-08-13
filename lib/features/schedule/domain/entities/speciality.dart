import 'package:equatable/equatable.dart';

class Speciality extends Equatable {
  const Speciality({
    required this.name,
    required this.abbrev,
    required this.educationFormName,
    required this.code,
  });

  final String name;
  final String abbrev;
  final String educationFormName;
  final String code;

  @override
  List<Object?> get props => [name, abbrev, educationFormName, code];
}
