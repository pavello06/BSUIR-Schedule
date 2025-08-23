import 'package:flutter/material.dart';

import 'photo_widget.dart';
import 'popup_menu_button_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.isNetworkPhoto,
    required this.pathToPhoto,
    required this.errorPhoto,
    required this.title,
    required this.subtitle,
    required this.onTaps,
    required this.icons,
    required this.texts,
  });

  final bool isNetworkPhoto;
  final String pathToPhoto;
  final IconData errorPhoto;

  final String title;
  final Widget? subtitle;

  final List<GestureTapCallback?> onTaps;
  final List<Icon> icons;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          PhotoWidget(
            isNetworkImage: isNetworkPhoto,
            pathToImage: pathToPhoto,
            errorIconData: errorPhoto,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (subtitle != null) subtitle!,
              ],
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButtonWidget(onTaps: onTaps, icons: icons, texts: texts),
        ],
      ),
    );
  }
}
