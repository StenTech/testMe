import 'package:flutter/material.dart';

///
/// Seatch bar widget
///
/// This widget is used to display a search bar in the app.
///
class SearchBarComponent extends StatelessWidget {
  const SearchBarComponent({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTapOutside: (pointerDownOutside) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus();
        },
      ),
    );
  }
}
