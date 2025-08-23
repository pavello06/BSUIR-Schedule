import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/app_colors.dart';
import '../card_widget.dart';

class ScheduleInfoWidget extends StatefulWidget {
  const ScheduleInfoWidget({
    super.key,
    required this.isNetworkPhoto,
    required this.pathToPhoto,
    required this.errorPhoto,
    required this.title,
    required this.subtitle,
    required this.onTaps,
    required this.icons,
    required this.texts,
    required this.content,
  });

  final bool isNetworkPhoto;
  final String pathToPhoto;
  final IconData errorPhoto;

  final String title;
  final Widget? subtitle;

  final List<GestureTapCallback?> onTaps;
  final List<Icon> icons;
  final List<String> texts;

  final Widget content;

  @override
  State<ScheduleInfoWidget> createState() => _ScheduleInfoWidgetState();
}

class _ScheduleInfoWidgetState extends State<ScheduleInfoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isFull = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleContent() {
    setState(() {
      _isFull = !_isFull;
      if (_isFull) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Row(children: [Icon(Icons.info), SizedBox(width: 5), Text('Информация')]),
        ),

        Container(color: AppColors.grey, width: mq.width, height: 2),

        InkWell(
          onTap: _toggleContent,
          child: CardWidget(
            isNetworkPhoto: widget.isNetworkPhoto,
            pathToPhoto: widget.pathToPhoto,
            errorPhoto: widget.errorPhoto,
            title: widget.title,
            subtitle: widget.subtitle,
            onTaps: widget.onTaps,
            icons: widget.icons,
            texts: widget.texts,
          ),
        ),

        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          child: Column(
            children: [
              Container(color: AppColors.grey, width: mq.width, height: 1),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: widget.content,
              ),
            ],
          ),
        ),

        Container(color: AppColors.grey, width: mq.width, height: 2),
      ],
    );
  }
}
