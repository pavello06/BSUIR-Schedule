import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/themes/app_colors.dart';
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
      decoration: InputDecoration(
        hintText: context.locale.search,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
      onChanged: (query) => _search(context, query),
      onSubmitted: (query) => _search(context, query),
      cursorColor: AppColors.primaryColor,
    );
  }

  void _search(BuildContext context, String query) {
    context.read<SearchBloc>().add(
      SearchListEvent(
        isGroup: isGroup,
        query: query,
        words: isGroup ? {'course': context.locale.course} : {},
      ),
    );
  }
}
