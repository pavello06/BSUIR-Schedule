abstract class SavedSchedulesEvent {}

class GetListEvent extends SavedSchedulesEvent {}

class RemoveScheduleEvent extends SavedSchedulesEvent {
  RemoveScheduleEvent({required this.isGroup, required this.query});

  final bool isGroup;
  final String query;
}
