import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final gb = Get.find<Global>();
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  logar() {
    Get.toNamed(MainScreen.router);
  }
}
