import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/search/ui/search_btn.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.hasLead,
    this.showSearch = false,
    this.showLogo = false,
    this.title,
    this.titleWidget,
    this.centerTitle = false,
    this.actions,
    this.logoHeight = 24.0,
    this.height = 56.0,
    this.backgroundColor,
    this.showDivider = false,
    this.onBack,
    this.leading,
  });

  /// Main home bar with Logo + Search
  const CustomAppBar.home({
    super.key,
    this.actions,
    this.logoHeight = 24.0,
    this.height = 56.0,
    this.backgroundColor,
    this.showDivider = false,
  })  : hasLead = false,
        showSearch = true,
        showLogo = true,
        title = null,
        titleWidget = null,
        centerTitle = false,
        onBack = null,
        leading = null;

  /// Standard screen bar with Title + optional back button & actions
  const CustomAppBar.title({
    super.key,
    required this.title,
    this.hasLead,
    this.showLogo = false,
    this.logoHeight = 24.0,
    this.titleWidget,
    this.centerTitle = false,
    this.actions,
    this.height = 56.0,
    this.backgroundColor,
    this.showDivider = false,
    this.onBack,
    this.leading,
  }) : showSearch = false;

  /// Search screen bar with Back button + Search bar + actions
  const CustomAppBar.search({
    super.key,
    this.hasLead = true,
    this.actions,
    this.height = 56.0,
    this.backgroundColor,
    this.showDivider = false,
    this.onBack,
    this.leading,
  })  : showSearch = true,
        showLogo = false,
        title = null,
        titleWidget = null,
        centerTitle = false,
        logoHeight = 24.0;

  final bool? hasLead;
  final bool showSearch;
  final bool showLogo;
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;
  final double logoHeight;
  final double height;
  final Color? backgroundColor;
  final bool showDivider;
  final VoidCallback? onBack;
  final Widget? leading;

  @override
  Size get preferredSize => Size.fromHeight(height + (showDivider ? 1.0 : 0.0));

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    final bool shouldShowBack = leading != null || (hasLead ?? canPop);

    Widget? leadWidget = leading;
    if (leadWidget == null && shouldShowBack) {
      leadWidget = BackButton(
        color: AppColor.c121212,
        onPressed: onBack,
      );
    }

    // Home layout: Logo + Search in single row
    if (showLogo && showSearch) {
      return AppBar(
        backgroundColor: backgroundColor ?? AppColor.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height,
        automaticallyImplyLeading: false,
        leading: leadWidget,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/trond-logo.png",
                height: logoHeight,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: SearchBtn(height: 38),
              ),
            ],
          ),
        ),
        actions:
            actions != null ? [...actions!, const SizedBox(width: 8)] : null,
        bottom: showDivider
            ? const PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                    height: 1.0, thickness: 1.0, color: Color(0xFFF0F0F0)),
              )
            : null,
      );
    }

    // Search layout: Back + Search bar
    if (showSearch) {
      return AppBar(
        backgroundColor: backgroundColor ?? AppColor.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height,
        automaticallyImplyLeading: false,
        leading: leadWidget,
        titleSpacing: shouldShowBack ? 0 : 16,
        title: const Padding(
          padding: EdgeInsetsDirectional.only(end: 12.0),
          child: SearchBtn(height: 38),
        ),
        actions:
            actions != null ? [...actions!, const SizedBox(width: 8)] : null,
        bottom: showDivider
            ? const PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                    height: 1.0, thickness: 1.0, color: Color(0xFFF0F0F0)),
              )
            : null,
      );
    }

    // Standard title layout
    Widget? titleContent = titleWidget;
    if (titleContent == null && title != null && title!.isNotEmpty) {
      final textWidget = Text(
        title!,
        style: const TextStyle(
          color: AppColor.c121212,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
      );
      if (showLogo) {
        titleContent = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/trond-logo.png",
              height: logoHeight,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            textWidget,
          ],
        );
      } else {
        titleContent = textWidget;
      }
    } else if (titleContent == null && showLogo) {
      titleContent = Image.asset(
        "assets/images/trond-logo.png",
        height: logoHeight,
        fit: BoxFit.contain,
      );
    }

    return AppBar(
      backgroundColor: backgroundColor ?? AppColor.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      leading: leadWidget,
      title: titleContent,
      centerTitle: centerTitle,
      titleSpacing: shouldShowBack ? 4 : 16,
      actions: actions != null ? [...actions!, const SizedBox(width: 8)] : null,
      bottom: showDivider
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                  height: 1.0, thickness: 1.0, color: Color(0xFFF0F0F0)),
            )
          : null,
    );
  }
}

/// Backward compatibility alias
typedef AppBarWidget2 = CustomAppBar;
