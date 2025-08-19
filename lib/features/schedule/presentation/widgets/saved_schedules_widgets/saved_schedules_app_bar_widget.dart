import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';

class SavedSchedulesAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SavedSchedulesAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(
        context.locale.mySchedules,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          icon: Icon(Icons.add),
        ),
      ],
      centerTitle: true,
      toolbarHeight: preferredSize.height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
