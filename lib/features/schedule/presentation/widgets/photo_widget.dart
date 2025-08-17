import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/themes/app_colors.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.isNetworkPhoto,
    required this.pathToPhoto,
    required this.errorPhoto,
  });

  final bool isNetworkPhoto;
  final String pathToPhoto;
  final IconData errorPhoto;

  @override
  Widget build(BuildContext context) {
    return ClipOval(child: isNetworkPhoto ? getNetworkPhoto(context) : getFilePhoto(context));
  }

  Widget getNetworkPhoto(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: pathToPhoto,
      errorWidget: (context, url, error) => getErrorPhoto(context),
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    );
  }

  Widget getFilePhoto(BuildContext context) {
    return Image.file(
      File(pathToPhoto),
      errorBuilder: (context, url, error) => getErrorPhoto(context),
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    );
  }

  Widget getErrorPhoto(BuildContext context) {
    return Container(
      color: context.theme.primaryColor,
      width: 60,
      height: 60,
      child: Icon(errorPhoto, size: 35, color: AppColors.foregroundColor),
    );
  }
}
