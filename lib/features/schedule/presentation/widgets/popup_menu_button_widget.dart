import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  const PopupMenuButtonWidget({
    super.key,
    required this.onTaps,
    required this.icons,
    required this.texts,
  });

  final List<GestureTapCallback?> onTaps;
  final List<Icon> icons;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        final popupMenuItems = <PopupMenuItem>[];
        for (int i = 0; i < onTaps.length; i++) {
          popupMenuItems.add(
            PopupMenuItem(
              value: i + 1,
              onTap: onTaps[i],
              child: Row(children: [icons[i], const SizedBox(width: 5), Text(texts[i])]),
            ),
          );
        }
        return popupMenuItems;
      },
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(AppColors.primaryColor)),
      padding: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(40),
      offset: Offset(-50, 0),
    );
  }
}
