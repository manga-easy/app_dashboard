import 'package:dashboard_manga_easy/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_manager/manager_page.dart';

class SplashPage extends StatefulWidget {
  static const route = '/Splash';
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ManagerPage<SplashController, SplashPage> {
  @override
  void initState() {
    ct.onNavigation(
      (event) => context.pushReplacement(event),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
