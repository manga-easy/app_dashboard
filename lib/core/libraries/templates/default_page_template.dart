import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/widgets/error_pages/error_default_page.dart';
import 'package:dashboard_manga_easy/core/libraries/widgets/error_pages/logged_out_page.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_page_builder.dart';

class DefaultPageTemplate extends StatelessWidget {
  final Widget Function() pageDone;
  final StateManager state;
  final Object? error;
  final Widget Function()? pageInitial;
  final Widget appBar;
  const DefaultPageTemplate({
    super.key,
    required this.pageDone,
    required this.state,
    required this.error,
    this.pageInitial,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return ManagerPageBuilder(
      state: state,
      pageDone: pageDone,
      error: error,
      padding: const EdgeInsets.all(AppTheme.defaultPadding),
      pageInitial: pageInitial ??
          () => const Center(
                child: CircularProgressIndicator(),
              ),
      pageError: (error) => const ErrorDefaultPage(),
      pageDisconnected: () => const ErrorDefaultPage(),
      pageLoading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      pageLoggedOut: () => const LoggedOutPage(),
      pageMaintenance: () => const ErrorDefaultPage(),
      appBar: AppBar(
        title: appBar,
      ),
    );
  }
}
