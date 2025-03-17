import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/build_context.ext.dart';
import 'package:news_app/core/utils/constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget> actions;
  Color backgroundColor;
  Color textColor;
  IconThemeData iconTheme;
  TabBar? bottom;

  CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.textColor = AppColor.lightModePurple,
    this.backgroundColor = AppColor.blue,
    this.iconTheme = const IconThemeData(color: Colors.white),
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      iconTheme: iconTheme,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: context.deviceWidth * 0.05,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                color: Colors.white, // Background color for TabBar
                child: bottom,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => bottom == null
      ? const Size.fromHeight(56)
      : const Size.fromHeight(100); // Adjust height for AppBar with TabBar
}
