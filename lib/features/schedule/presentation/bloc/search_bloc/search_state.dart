import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee/employee.dart';
import '../../../domain/entities/group/group.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class InitialState extends SearchState {
  const InitialState();
}

abstract class WithListsState extends SearchState {
  const WithListsState({
    required this.groups,
    required this.employees,
    required this.foundedGroups,
    required this.foundedEmployees,
  });

  final List<Group>? groups;
  final List<Employee>? employees;
  final List<Group>? foundedGroups;
  final List<Employee>? foundedEmployees;

  @override
  List<Object?> get props => [...super.props, groups, employees, foundedGroups, foundedEmployees];
}

class LoadingState extends WithListsState {
  LoadingState({WithListsState? state, required this.hasData})
    : super(
        groups: state?.groups,
        employees: state?.employees,
        foundedGroups: state?.foundedGroups,
        foundedEmployees: state?.foundedEmployees,
      );

  final bool hasData;

  @override
  List<Object?> get props => [...super.props, hasData];
}

class LoadedState extends WithListsState {
  const LoadedState({
    required super.groups,
    required super.employees,
    required super.foundedGroups,
    required super.foundedEmployees,
    required this.hasError,
  });

  LoadedState.fromState({WithListsState? state, required this.hasError})
    : super(
        groups: state?.groups,
        employees: state?.employees,
        foundedGroups: state?.foundedGroups,
        foundedEmployees: state?.foundedEmployees,
      );

  final bool? hasError;

  @override
  List<Object?> get props => [...super.props, hasError];
}

class EmptyState extends SearchState {
  const EmptyState();
}
