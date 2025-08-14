abstract class SearchEvent {
  const SearchEvent();
}

class GetListsEvent extends SearchEvent {
  const GetListsEvent();
}

class UpdateListsEvent extends SearchEvent {
  const UpdateListsEvent();
}

abstract class SearchListEvent extends SearchEvent {
  const SearchListEvent({required this.query, required this.words});

  final String query;
  final Map<String, String> words;
}

class SearchGroupListEvent extends SearchListEvent {
  const SearchGroupListEvent({required super.query, required super.words});
}

class SearchEmployeeListEvent extends SearchListEvent {
  const SearchEmployeeListEvent({required super.query, required super.words});
}
