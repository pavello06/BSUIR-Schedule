import 'package:equatable/equatable.dart';

import 'employee.dart';
import 'group.dart';

class SavedSchedule extends Equatable {
  const SavedSchedule({
    required this.isGroup,
    required this.group,
    required this.employee,
    required this.query,
    required this.isActive,
  });

  final bool isGroup;
  final Group? group;
  final Employee? employee;
  final String query;
  final bool isActive;

  @override
  List<Object?> get props => [isGroup, group, employee, query, isActive];
}
