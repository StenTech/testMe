import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testme/common/theme/app_color.dart';

/// The owner's avatar widget
///
class OwnerAvatar extends StatelessWidget {
  const OwnerAvatar(
      {Key? key, this.radius, this.image = "assets/images/owner.png"})
      : super(key: key);

  /// The radius of the avatar
  final double? radius;

  /// The image of the avatar
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius ?? 60,
      width: radius ?? 60,
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: image == "null"
              ? const AssetImage("assets/images/owner.png")
              : FileImage(File(image)) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
