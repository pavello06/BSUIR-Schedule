import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../bloc/search_bloc/search_event.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      title: Text(
        context.locale.addingSchedule,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<SearchBloc>().add(UpdateListsEvent());
          },
          icon: Icon(Icons.update),
        ),
      ],
      centerTitle: true,
      toolbarHeight: preferredSize.height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
