import 'package:equatable/equatable.dart';

class Faculty extends Equatable {
  const Faculty({required this.name, required this.abbrev, required this.id});

  final String name;
  final String abbrev;
  final int id;

  @override
  List<Object?> get props => [name, abbrev, id];
}
