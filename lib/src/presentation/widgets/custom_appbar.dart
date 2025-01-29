import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

import '../../apptheme.dart';
import '../../utilities.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.appBarHeight, required this.title});
  final double appBarHeight;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: appBarHeight,
      leading: Utilities.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : const SizedBox(),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      title: TextLabel(
        color: AppTheme.white,
        text: title,
        fontSize: Utilities.sizeFontWithDesityForDisplay(context, 24),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkBlue,
              AppTheme.lightBlue,
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  // Size get preferredSize => const Size.fromHeight(72.0);
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
