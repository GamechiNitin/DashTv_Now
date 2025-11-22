import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/widget/exit_dialog.dart';
import 'drawer_menu_service.dart';

class DrawerMenuSheet extends StatelessWidget {
  const DrawerMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetTile(
              icon: Icons.ios_share,
              label: "Share App",
              onTap: () {
                Navigator.pop(context);
                DrawerMenuService.shareApp();
              },
            ),

            _SheetTile(
              icon: Icons.thumb_up_alt_outlined,
              label: "Rate Us",
              onTap: () {
                Navigator.pop(context);
                DrawerMenuService.rateApp();
              },
            ),
            _SheetTile(
              icon: Icons.reviews_outlined,
              label: "Feedback",
              onTap: () {
                Navigator.pop(context);
                DrawerMenuService.sendFeedback();
              },
            ),
            _SheetTile(
              icon: Icons.phone_in_talk_outlined,
              label: "Contact Support",
              onTap: () {
                Navigator.pop(context);
                DrawerMenuService.contactSupport();
              },
            ),
            _SheetTile(
              icon: Icons.more_horiz,
              label: "Exit",
              onTap: () async {
                GoRouter.of(context).pop();
                await context.showExitDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SheetTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 20, color: Colors.black87),
      title: Text(label, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
    );
  }
}
