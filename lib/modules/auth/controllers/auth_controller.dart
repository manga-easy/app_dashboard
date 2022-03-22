import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/main/views/main_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final gb = Get.find<Global>();
  final app = Get.find<AppwriteClient>();
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  logar() {
    try {
    app.account.createSession(email: email, password: password)
    Get.offAllNamed(MainScreen.router);
     } catch (e) {
       Get.defaultDialog(title: 'Erro', middleText: e.toString());
    }
  }
}
