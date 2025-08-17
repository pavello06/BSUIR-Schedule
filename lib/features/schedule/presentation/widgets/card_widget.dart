import 'package:flutter/material.dart';

import 'photo_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.onTap,
    required this.isNetworkPhoto,
    required this.pathToPhoto,
    required this.errorPhoto,
    required this.content,
    this.action,
  });

  final GestureTapCallback? onTap;

  final bool isNetworkPhoto;
  final String pathToPhoto;
  final IconData errorPhoto;

  final Widget content;

  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: IntrinsicHeight(
            child: Row(
              children: [
                PhotoWidget(
                  isNetworkPhoto: isNetworkPhoto,
                  pathToPhoto: pathToPhoto,
                  errorPhoto: errorPhoto,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: content),
                ),

                const SizedBox(width: 10),

                ?action,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
