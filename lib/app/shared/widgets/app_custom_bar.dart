import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class AppCustomBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButton;
  final bool isActionButton;
  final Widget? actionButton;
  final bool lightBg;

  const AppCustomBar({
    super.key,
    required this.title,
    this.lightBg = true,
    this.isBackButton = true,
    this.isActionButton = false,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightBg ? AppStyle.light : Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: AppStyle.dark),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(title, style: AppFonts.xlSemiBold),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
