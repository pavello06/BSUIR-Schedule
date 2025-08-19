import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/employee/employee.dart';
import '../../../domain/entities/group/group.dart';
import '../../../domain/usecases/get_employees.dart';
import '../../../domain/usecases/get_groups.dart';
import '../../../domain/usecases/save_schedule.dart';
import '../../../domain/usecases/search_employees.dart';
import '../../../domain/usecases/search_groups.dart';
import '../../../domain/usecases/update_employees.dart';
import '../../../domain/usecases/update_groups.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.getGroups,
    required this.updateGroups,
    required this.getEmployees,
    required this.updateEmployees,
    required this.searchGroups,
    required this.searchEmployees,
    required this.saveSchedule,
  }) : super(InitialState()) {
    on<GetListsEvent>(_onGetLists);
    on<UpdateListsEvent>(_onUpdateLists);
    on<SearchListEvent>(_onSearchList);
    on<SaveScheduleEvent>(_onSaveSchedule);
  }

  final GetGroups getGroups;
  final UpdateGroups updateGroups;
  final GetEmployees getEmployees;
  final UpdateEmployees updateEmployees;
  final SearchGroups searchGroups;
  final SearchEmployees searchEmployees;
  final SaveSchedule saveSchedule;

  void _onGetLists(GetListsEvent event, Emitter<SearchState> emit) async {
    await _getOrUpdateLists(true, emit);
  }

  void _onUpdateLists(UpdateListsEvent event, Emitter<SearchState> emit) async {
    await _getOrUpdateLists(false, emit);
  }

  Future<void> _getOrUpdateLists(bool isGet, Emitter<SearchState> emit) async {
    emit(
      LoadingState(
        state: state is WithListsState ? state as WithListsState : null,
        hasData: state is WithListsState,
      ),
    );

    final groupListOrFailure = await (isGet ? getGroups(NoParams()) : updateGroups(NoParams()));
    final employeeListOrFailure = await (isGet
        ? getEmployees(NoParams())
        : updateEmployees(NoParams()));

    emit(
      groupListOrFailure.fold(
        (failure) => (state as LoadingState).hasData
            ? LoadedState.fromState(state: state as WithListsState, hasError: true)
            : EmptyState(),
        (groupList) => employeeListOrFailure.fold(
          (failure) => (state as LoadingState).hasData
              ? LoadedState.fromState(state: state as WithListsState, hasError: true)
              : EmptyState(),
          (employeeList) => LoadedState(
            groups: groupList,
            employees: employeeList,
            foundedGroups: groupList,
            foundedEmployees: employeeList,
            hasError: false,
          ),
        ),
      ),
    );
  }

  void _onSearchList(SearchListEvent event, Emitter<SearchState> emit) async {
    final searchWithListsState = state as WithListsState;

    final groups = searchWithListsState.groups!;
    final employees = searchWithListsState.employees!;
    final foundedGroups = searchWithListsState.foundedGroups!;
    final foundedEmployees = searchWithListsState.foundedEmployees!;

    final listOrFailure = event.isGroup
        ? await searchGroups(
            SearchGroupsParams(groups: groups, query: event.query, words: event.words),
          )
        : await searchEmployees(
            SearchEmployeesParams(employeeList: employees, query: event.query, words: event.words),
          );

    emit(
      listOrFailure.fold(
        (failure) => EmptyState(),
        (list) => LoadedState(
          groups: groups,
          employees: employees,
          foundedGroups: event.isGroup ? list as List<Group> : foundedGroups,
          foundedEmployees: !event.isGroup ? list as List<Employee> : foundedEmployees,
          hasError: null,
        ),
      ),
    );
  }

  void _onSaveSchedule(SaveScheduleEvent event, Emitter<SearchState> emit) async {
    emit(
      LoadingState(
        state: state is WithListsState ? state as WithListsState : null,
        hasData: state is WithListsState,
      ),
    );

    final successOrFailure = await saveSchedule(
      SaveScheduleParams(
        isGroup: event.isGroup,
        group: event.group,
        employee: event.employee,
        query: event.query,
      ),
    );

    emit(
      successOrFailure.fold(
        (failure) => LoadedState.fromState(state: state as WithListsState, hasError: true),
        (success) => LoadedState.fromState(state: state as WithListsState, hasError: false),
      ),
    );
  }
}
