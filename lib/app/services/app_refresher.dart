import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/core/utils/app_localizations.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

typedef RefreshCallback = Function()?;
typedef LoadMoreCallback = Function()?;

class AppRefresher extends StatefulWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final LoadMoreCallback onLoadMore;
  final ScrollPhysics? physics;
  final Color? headerTextColor;
  final Color? footerTextColor;

  const AppRefresher({
    super.key,
    required this.child,
    this.onRefresh,
    this.physics,
    this.onLoadMore,
    this.headerTextColor,
    this.footerTextColor,
  });

  @override
  State<AppRefresher> createState() => _AppRefresherState();
}

class _AppRefresherState extends State<AppRefresher> {
  late final RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onRefresh() async {
    await widget.onRefresh?.call();
    controller.refreshCompleted();
  }

  void onLoadMore() async {
    await widget.onLoadMore?.call();
    controller.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return NotificationListener<ScrollNotification>(
      onNotification: (_) => true,
      child: SmartRefresher(
        primary: false,
        controller: controller,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        enablePullDown: widget.onRefresh != null,
        enablePullUp: widget.onLoadMore != null,
        physics: widget.physics ?? const BouncingScrollPhysics(),
        header: ClassicHeader(
          refreshStyle: RefreshStyle.Follow,
          releaseText: AppLocalizations.releaseToRefresh(),
          refreshingText: AppLocalizations.refreshing(),
          idleText: AppLocalizations.pullToRefresh(),
          completeText: AppLocalizations.refreshCompleted(),
          failedText: AppLocalizations.refreshFailed(),
          textStyle: AppFonts.mdRegular.copyWith(
            color: widget.headerTextColor ?? colorScheme.onSurface,
          ),
          outerBuilder: (child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: child,
            );
          },
          idleIcon: Icon(
            Icons.arrow_downward_rounded,
            color: widget.headerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          releaseIcon: Icon(
            Icons.arrow_upward_rounded,
            color: widget.headerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          completeIcon: Icon(
            Icons.check_rounded,
            color: widget.headerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          failedIcon: Icon(
            Icons.error_outline_outlined,
            color: widget.headerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          refreshingIcon: CupertinoActivityIndicator(
            color: widget.headerTextColor ?? colorScheme.onSurface,
            radius: 8,
          ),
        ),
        footer: ClassicFooter(
          height: 100,
          canLoadingText: AppLocalizations.releaseToLoadMore(),
          loadingText: AppLocalizations.loading(),
          idleText: AppLocalizations.pullToLoadMore(),
          failedText: AppLocalizations.loadFailed(),
          loadStyle: LoadStyle.ShowWhenLoading,
          textStyle: AppFonts.mdRegular.copyWith(
            color: widget.footerTextColor ?? colorScheme.onSurface,
          ),
          outerBuilder: (child) {
            return Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                      backgroundColor: AppStyle.primary,
                      strokeWidth: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'pull-up-load-more'.tr,
                    style: AppFonts.mdRegular.copyWith(
                      color: widget.footerTextColor ?? colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          },
          idleIcon: Icon(
            Icons.arrow_upward_rounded,
            color: widget.footerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          canLoadingIcon: Icon(
            Icons.arrow_downward_rounded,
            color: widget.footerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          failedIcon: Icon(
            Icons.error_outline_outlined,
            color: widget.footerTextColor ?? colorScheme.onSurface,
            size: 16,
          ),
          loadingIcon: const SizedBox.shrink(),
        ),
        child: widget.child,
      ),
    );
  }
}
