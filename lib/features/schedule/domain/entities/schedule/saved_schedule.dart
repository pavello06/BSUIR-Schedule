import 'package:equatable/equatable.dart';

import '../employee/employee.dart';
import '../group/group.dart';

class SavedSchedule extends Equatable {
  const SavedSchedule({
    required this.title,
    required this.isGroup,
    required this.group,
    required this.employee,
    required this.query,
    required this.isActive,
  });

  final String? title;
  final bool isGroup;
  final Group? group;
  final Employee? employee;
  final String query;
  final bool isActive;

  @override
  List<Object?> get props => [title, isGroup, group, employee, query, isActive];
}
