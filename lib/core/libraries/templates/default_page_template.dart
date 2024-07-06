import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/pages/error_default_page.dart';
import 'package:flutter/material.dart';

class DefaultPageTemplate extends StatelessWidget {
  final Widget done;
  final Widget? error;
  final Widget? initial;
  final Widget? loading;
  final StatusBuild state;
  const DefaultPageTemplate({
    super.key,
    required this.done,
    this.error,
    this.initial,
    this.loading,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case StatusBuild.erro:
        return error ?? const ErrorDefaultPage();
      case StatusBuild.initial:
        return initial ??
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
      case StatusBuild.loading:
        return loading ??
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
      case StatusBuild.done:
        return done;
    }
  }
}
