import 'package:flutter/material.dart';
import 'package:testme/common/theme/app_color.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key, this.title, required this.child}) : super(key: key);
  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryBackgroundColor,
      child: child,
    );
  }
}
