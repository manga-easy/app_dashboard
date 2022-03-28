import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/modules/users/models/users.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  List lista = [].obs;
  final app = Get.find<AppwriteAdmin>();
  var pesquisa = ''.obs;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    carregaUsers();
    super.onInit();
  }

  carregaUsers() async {
    lista.clear();
    var retorno = await app.users.list(limit: 100);
    var list = retorno.users;
    for (var item in list) {
      lista.add(UsersL.fromJson(item.toMap()));
    }
  }

  pesquisaUser() async {
    var retorno = await app.users.list(search: pesquisa.value);
    var list = retorno.users;
    lista.clear();
    for (var item in list) {
      lista.add(UsersL.fromJson(item.toMap()));
    }
  }
}
