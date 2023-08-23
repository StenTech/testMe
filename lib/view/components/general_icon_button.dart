import 'package:flutter/material.dart';
import 'package:testme/common/theme/app_color.dart';

class GeneralIconButton extends StatelessWidget {
  const GeneralIconButton({super.key, this.onPressed, this.icon});

  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: AppColor.iconButtonBackgroundColor,
        // make circle shape
        shape: BoxShape.circle,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        splashRadius: 20,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: AppColor.secondaryColor,
        ),
      ),
    );
  }
}
