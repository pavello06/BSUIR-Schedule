import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchAppBarWidget({super.key, required this.refreshKeys});

  final List<GlobalKey<RefreshIndicatorState>> refreshKeys;

  @override
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
            for (final key in refreshKeys) {
              key.currentState?.show();
            }
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
