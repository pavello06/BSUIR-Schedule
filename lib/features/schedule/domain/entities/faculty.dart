import 'package:equatable/equatable.dart';

class Faculty extends Equatable {
  const Faculty({required this.name, required this.abbrev});

  final String name;
  final String abbrev;

  @override
  List<Object?> get props => [name, abbrev];
}
