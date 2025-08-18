import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_saved_schedules.dart';
import '../../../domain/usecases/remove_schedule.dart';
import 'saved_schedules_event.dart';
import 'saved_schedules_state.dart';

class SavedSchedulesBloc extends Bloc<SavedSchedulesEvent, SavedSchedulesState> {
  SavedSchedulesBloc({required this.getSavedScheduleList, required this.removeSchedule})
    : super(InitialState()) {
    on<GetListEvent>(_onGetList);
    on<RemoveScheduleEvent>(_onRemoveSchedule);
  }

  final GetSavedSchedules getSavedScheduleList;
  final RemoveSchedule removeSchedule;

  void _onGetList(GetListEvent event, Emitter<SavedSchedulesState> emit) async {
    await _getList(emit);
  }

  void _onRemoveSchedule(RemoveScheduleEvent event, Emitter<SavedSchedulesState> emit) async {
    await removeSchedule(RemoveScheduleParams(isGroup: event.isGroup, query: event.query));

    await _getList(emit);
  }

  Future<void> _getList(Emitter<SavedSchedulesState> emit) async {
    final savedScheduleListOrFailure = await getSavedScheduleList(NoParams());

    emit(
      savedScheduleListOrFailure.fold(
        (failure) => EmptyState(),
        (savedScheduleList) => savedScheduleList.isEmpty
            ? EmptyState()
            : LoadedState(savedScheduleList: savedScheduleList),
      ),
    );
  }
}
