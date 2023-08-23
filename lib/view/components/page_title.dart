import 'package:flutter/material.dart';
import 'package:testme/common/theme/app_color.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return title == null ? Container() : _buildTitle();
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: [
          Text(
            title!,
            style: const TextStyle(
              color: AppColor.primaryTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
