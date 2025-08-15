import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/usecases/get_employee_list.dart';
import '../../../domain/usecases/get_group_list.dart';
import '../../../domain/usecases/search_employee_list.dart';
import '../../../domain/usecases/search_group_list.dart';
import '../../../domain/usecases/update_employee_list.dart';
import '../../../domain/usecases/update_group_list.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetGroupList getGroupList;
  final UpdateGroupList updateGroupList;
  final GetEmployeeList getEmployeeList;
  final UpdateEmployeeList updateEmployeeList;
  final SearchGroupList searchGroupList;
  final SearchEmployeeList searchEmployeeList;

  SearchBloc({
    required this.getGroupList,
    required this.updateGroupList,
    required this.getEmployeeList,
    required this.updateEmployeeList,
    required this.searchGroupList,
    required this.searchEmployeeList,
  }) : super(SearchInitialState()) {
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
      SearchLoadingState(
        state: state is SearchWithListsState
            ? state as SearchWithListsState
            : null,
        hasData: state is SearchWithListsState,
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
        (failure) => (state as SearchLoadingState).hasData
            ? SearchLoadedState.fromState(
                state: state as SearchWithListsState,
                hasError: true,
              )
            : SearchEmptyState(),
        (groupList) => employeeListOrFailure.fold(
          (failure) => (state as SearchLoadingState).hasData
              ? SearchLoadedState.fromState(
                  state: state as SearchWithListsState,
                  hasError: true,
                )
              : SearchEmptyState(),
          (employeeList) => SearchLoadedState(
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
    final searchWithListsState = state as SearchWithListsState;

    final groupList = searchWithListsState.groupList!;
    final employeeList = searchWithListsState.employeeList!;
    final preparedGroupList = searchWithListsState.preparedGroupList!;
    final preparedEmployeeList = searchWithListsState.preparedEmployeeList!;

    final listOrFailure = isGroup
        ? await searchGroupList(
            SearchGroupListParams(
              groupList: groupList,
              query: event.query,
              words: event.words,
            ),
          )
        : await searchEmployeeList(
            SearchEmployeeListParams(
              employeeList: employeeList,
              query: event.query,
              words: event.words,
            ),
          );

    emit(
      listOrFailure.fold(
        (failure) => SearchEmptyState(),
        (list) => SearchLoadedState(
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
