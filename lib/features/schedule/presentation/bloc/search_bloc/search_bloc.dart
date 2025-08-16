import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/usecases/get_employees.dart';
import '../../../domain/usecases/get_groups.dart';
import '../../../domain/usecases/search_employees.dart';
import '../../../domain/usecases/search_groups.dart';
import '../../../domain/usecases/update_employees.dart';
import '../../../domain/usecases/update_groups.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetGroups getGroupList;
  final UpdateGroups updateGroupList;
  final GetEmployees getEmployeeList;
  final UpdateEmployees updateEmployeeList;
  final SearchGroups searchGroupList;
  final SearchEmployees searchEmployeeList;

  SearchBloc({
    required this.getGroupList,
    required this.updateGroupList,
    required this.getEmployeeList,
    required this.updateEmployeeList,
    required this.searchGroupList,
    required this.searchEmployeeList,
  }) : super(InitialState()) {
    on<GetListsEvent>(_onGetLists);
    on<UpdateListsEvent>(_onUpdateLists);
    on<SearchGroupListEvent>(_onSearchGroupList);
    on<SearchEmployeeListEvent>(_onSearchEmployeeList);
  }

  void _onGetLists(GetListsEvent event, Emitter<SearchState> emit) async {
    await _getOrUpdateLists(true, emit);
  }

  void _onUpdateLists(UpdateListsEvent event, Emitter<SearchState> emit) async {
    await _getOrUpdateLists(false, emit);
  }

  Future<void> _getOrUpdateLists(bool isGet, Emitter<SearchState> emit) async {
    emit(
      LoadingState(
        state: state is WithListsState
            ? state as WithListsState
            : null,
        hasData: state is WithListsState,
      ),
    );

    final groupListOrFailure = await (isGet
        ? getGroupList(NoParams())
        : updateGroupList(NoParams()));
    final employeeListOrFailure = await (isGet
        ? getEmployeeList(NoParams())
        : updateEmployeeList(NoParams()));

    emit(
      groupListOrFailure.fold(
        (failure) => (state as LoadingState).hasData
            ? LoadedState.fromState(
                state: state as WithListsState,
                hasError: true,
              )
            : EmptyState(),
        (groupList) => employeeListOrFailure.fold(
          (failure) => (state as LoadingState).hasData
              ? LoadedState.fromState(
                  state: state as WithListsState,
                  hasError: true,
                )
              : EmptyState(),
          (employeeList) => LoadedState(
            groupList: groupList,
            employeeList: employeeList,
            preparedGroupList: groupList,
            preparedEmployeeList: employeeList,
            hasError: false,
          ),
        ),
      ),
    );
  }

  void _onSearchGroupList(
    SearchGroupListEvent event,
    Emitter<SearchState> emit,
  ) async {
    await _searchList(event, emit, true);
  }

  void _onSearchEmployeeList(
    SearchEmployeeListEvent event,
    Emitter<SearchState> emit,
  ) async {
    await _searchList(event, emit, false);
  }

  Future<void> _searchList(
    SearchListEvent event,
    Emitter<SearchState> emit,
    bool isGroup,
  ) async {
    final searchWithListsState = state as WithListsState;

    final groupList = searchWithListsState.groupList!;
    final employeeList = searchWithListsState.employeeList!;
    final preparedGroupList = searchWithListsState.preparedGroupList!;
    final preparedEmployeeList = searchWithListsState.preparedEmployeeList!;

    final listOrFailure = isGroup
        ? await searchGroupList(
            SearchGroupsParams(
              groups: groupList,
              query: event.query,
              words: event.words,
            ),
          )
        : await searchEmployeeList(
            SearchEmployeesParams(
              employeeList: employeeList,
              query: event.query,
              words: event.words,
            ),
          );

    emit(
      listOrFailure.fold(
        (failure) => EmptyState(),
        (list) => LoadedState(
          groupList: groupList,
          employeeList: employeeList,
          preparedGroupList: isGroup ? list as List<Group> : preparedGroupList,
          preparedEmployeeList: !isGroup
              ? list as List<Employee>
              : preparedEmployeeList,
          hasError: null,
        ),
      ),
    );
  }
}
