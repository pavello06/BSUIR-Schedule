import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_saved_schedule_list.dart';
import 'saved_schedules_event.dart';
import 'saved_schedules_state.dart';

class SavedSchedulesBloc
    extends Bloc<SavedSchedulesEvent, SavedSchedulesState> {
  final GetSavedScheduleList getSavedScheduleList;

  SavedSchedulesBloc({required this.getSavedScheduleList})
    : super(InitialState()) {
    on<GetListEvent>(_onGetList);
  }

  void _onGetList(GetListEvent event, Emitter<SavedSchedulesState> emit) async {
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
