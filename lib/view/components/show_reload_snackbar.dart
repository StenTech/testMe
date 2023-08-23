import 'package:flutter/material.dart';

showDataReloadedSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Data reloaded!'),
    ),
  );
}
