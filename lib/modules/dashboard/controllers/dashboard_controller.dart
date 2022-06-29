import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class DashboardController extends IController {
  final ServiceRoute serviceRoute;
  final AppwriteAdmin appwriteAdmin;
  var emblemasDoadores = ValueNotifier(<Emblema>[]);
  var status = ValueNotifier(StatusBuild.done);

  DashboardController({
    required this.serviceRoute,
    required this.appwriteAdmin,
  });

  @override
  void onClose() {
    emblemasDoadores.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaEmblemaDoadores();
  }

  void carregaEmblemaDoadores() async {
    try {
      if (serviceRoute.permissions!.value >= serviceRoute.levelAdmin) {
        var ret = await appwriteAdmin.database.listDocuments(
          collectionId: Emblema.collectionId,
          queries: [Query.equal('categoria', CategoriaEmblema.doacao.name)],
        );
        emblemasDoadores.value = ret.documents.map((e) => Emblema.fromJson(e.data)).toList();
      }
    } catch (e) {
      Helps.log(e);
    }
  }

  Future<int> calculaTotalAdquirido(String idEmblema) async {
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [Query.equal('idEmblema', idEmblema)],
      limit: 10,
    );
    return ret.total;
  }
}
