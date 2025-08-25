import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../domain/entities/group/group.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../bloc/search_bloc/search_event.dart';
import '../card_widget.dart';

class SearchGroupCardWidget extends StatelessWidget {
  const SearchGroupCardWidget({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SearchBloc>().add(SaveScheduleEvent(isGroup: true, group: group, query: group.name));
      },
      child: CardWidget(
        isNetworkPhoto: false,
        pathToPhoto: '',
        errorPhoto: Icons.people,

        title: group.name,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${group.faculty.abbrev} ${group.speciality.abbrev} ${group.speciality.educationFormName} ${context.locale.courseNumber(group.course)}',
              style: TextStyle(fontSize: 13),
            ),

            Text(group.speciality.code, style: TextStyle(fontSize: 13)),
          ],
        ),

        onTaps: [],
        icons: [],
        texts: [],
      ),
    );
  }
}
