import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/extensions/build_context_extension.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            getSearchFilterItemWidget(true, context),

            getSearchFilterItemWidget(false, context),
          ],
        ),

        Positioned(
          bottom: 0,
          left: 0,
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              final position =
                  (pageController.hasClients ? pageController.page ?? 0 : 0) * mq.width * 0.5;

              return Transform.translate(
                offset: Offset(position, 0),
                child: Container(
                  color: context.theme.primaryColor,
                  width: mq.width * 0.5,
                  height: 3,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getSearchFilterItemWidget(bool isGroup, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => pageController.animateToPage(
          isGroup ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isGroup ? Icons.people : Icons.person, size: 25),

              SizedBox(width: 5),

              Text(isGroup ? context.locale.groups : context.locale.teachers),
            ],
          ),
        ),
      ),
    );
  }
}
