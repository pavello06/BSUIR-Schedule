import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee.dart';
import '../../../domain/entities/group.dart';

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
    required this.groupList,
    required this.employeeList,
    required this.preparedGroupList,
    required this.preparedEmployeeList,
  });

  final List<Group>? groupList;
  final List<Employee>? employeeList;
  final List<Group>? preparedGroupList;
  final List<Employee>? preparedEmployeeList;

  @override
  List<Object?> get props => [
    ...super.props,
    groupList,
    employeeList,
    preparedGroupList,
    preparedEmployeeList,
  ];
}

class LoadingState extends WithListsState {
  LoadingState({WithListsState? state, required this.hasData})
    : super(
        groupList: state?.groupList,
        employeeList: state?.employeeList,
        preparedGroupList: state?.preparedGroupList,
        preparedEmployeeList: state?.preparedEmployeeList,
      );

  final bool hasData;

  @override
  List<Object?> get props => [...super.props, hasData];
}

class LoadedState extends WithListsState {
  const LoadedState({
    required super.groupList,
    required super.employeeList,
    required super.preparedGroupList,
    required super.preparedEmployeeList,
    required this.hasError,
  });

  LoadedState.fromState({
    WithListsState? state,
    required this.hasError,
  }) : super(
         groupList: state?.groupList,
         employeeList: state?.employeeList,
         preparedGroupList: state?.preparedGroupList,
         preparedEmployeeList: state?.preparedEmployeeList,
       );

  final bool? hasError;

  @override
  List<Object?> get props => [...super.props, hasError];
}

class EmptyState extends SearchState {
  const EmptyState();
}
