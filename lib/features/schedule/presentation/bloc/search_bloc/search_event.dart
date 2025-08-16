import '../../../domain/entities/employee.dart';
import '../../../domain/entities/group.dart';

abstract class SearchEvent {}

class GetListsEvent extends SearchEvent {}

class UpdateListsEvent extends SearchEvent {}

class SearchListEvent extends SearchEvent {
  SearchListEvent({required this.isGroup, required this.query, required this.words});

  final bool isGroup;
  final String query;
  final Map<String, String> words;
}

class SaveScheduleEvent extends SearchEvent {
  SaveScheduleEvent({required this.isGroup, this.group, this.employee, required this.query});

  final bool isGroup;
  final Group? group;
  final Employee? employee;
  final String query;
}
