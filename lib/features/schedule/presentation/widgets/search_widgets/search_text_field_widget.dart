import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../bloc/search_bloc/search_event.dart';
import '../../bloc/search_bloc/search_state.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.isGroup,
    required this.state,
  });

  final TextEditingController textEditingController;
  final bool isGroup;
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: context.locale.search),
      onChanged: (query) => _search(context, query),
      onSubmitted: (query) => _search(context, query),
    );
  }

  void _search(BuildContext context, String query) {
    context.read<SearchBloc>().add(
      isGroup
          ? SearchGroupListEvent(
              query: query,
              words: {'course': context.locale.course},
            )
          : SearchEmployeeListEvent(query: query, words: {}),
    );
  }
}
