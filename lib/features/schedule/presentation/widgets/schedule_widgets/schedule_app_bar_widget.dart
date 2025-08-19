import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_context_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/date_util.dart';

class ScheduleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ScheduleAppBarWidget({super.key, required this.week});

  final int? week;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.event_note)),
      title: Column(
        children: [
          Text(
            '${DateUtil.getCurrentDayOfWeek(context.locale.localeName)} ${DateUtil.getCurrentDay(context.locale.localeName)}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '$week неделя',
            style: TextStyle(color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      centerTitle: true,
      toolbarHeight: preferredSize.height,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
