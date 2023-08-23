import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testme/common/theme/app_color.dart';

import 'general_icon_button.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
    this.backButtonFunction,
    this.showBackButton = true,
  });

  final String? title;
  final VoidCallback? backButtonFunction;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // hide time en battery bar
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),

      // transparent: true,
      shadowColor: Colors.transparent,
      backgroundColor: AppColor.primaryBackgroundColor,
      leading: showBackButton
          ? GeneralIconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (backButtonFunction != null) {
                  backButtonFunction!();
                  return;
                }
                Navigator.pop(context);
              },
              icon: Icons.arrow_back,
            )
          : null,
      title: Text(
        title ?? 'simple app bar',
        style: const TextStyle(
          color: AppColor.secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // actions: [
      //   GeneralIconButton(
      //     onPressed: () {},
      //     icon: Icons.more_vert,
      //   ),
      //   const SizedBox(width: 10),
      // ],
      //centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
