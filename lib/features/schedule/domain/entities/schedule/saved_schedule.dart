import 'package:equatable/equatable.dart';

import '../employee/employee.dart';
import '../group/group.dart';

class SavedSchedule extends Equatable {
  const SavedSchedule({
    required this.isActive,
    required this.query,
    required this.isGroup,
    required this.group,
    required this.employee,
    required this.title,
  });

  final bool isActive;
  final String query;
  final bool isGroup;
  final Group? group;
  final Employee? employee;
  final String? title;

  @override
  List<Object?> get props => [isActive, query, isGroup, group, employee, title];
}
