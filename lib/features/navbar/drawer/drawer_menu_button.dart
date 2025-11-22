import 'package:flutter/material.dart';
import 'drawer_menu_sheet.dart';

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notes, color: Colors.black),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          builder: (_) => const DrawerMenuSheet(),
        );
      },
    );
  }
}
