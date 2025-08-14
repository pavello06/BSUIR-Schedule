import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee.dart';
import '../../../domain/entities/group.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

abstract class SearchWithListsState extends SearchState {
  const SearchWithListsState({
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

class SearchLoadingState extends SearchWithListsState {
  SearchLoadingState({SearchWithListsState? state, required this.hasData})
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

class SearchLoadedState extends SearchWithListsState {
  const SearchLoadedState({
    required super.groupList,
    required super.employeeList,
    required super.preparedGroupList,
    required super.preparedEmployeeList,
    required this.hasError,
  });

  SearchLoadedState.fromState({
    SearchWithListsState? state,
    required this.hasError,
  }) : super(
         groupList: state?.groupList,
         employeeList: state?.employeeList,
         preparedGroupList: state?.preparedGroupList,
         preparedEmployeeList: state?.preparedEmployeeList,
       );

  final bool hasError;

  @override
  List<Object?> get props => [...super.props, hasError];
}

class SearchEmptyState extends SearchState {}
