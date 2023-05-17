import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_admin.dart';

import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class DetalhesEmblemasController extends IController {
  final AppwriteAdmin appwriteAdmin;
  var lista = <EmblemaUser>[];
  var status = ValueNotifier(StatusBuild.loading);
  late Emblema emblema;

  DetalhesEmblemasController({required this.appwriteAdmin});

  @override
  void dispose() {
    super.dispose();
    status.dispose();
  }

  @override
  void init(BuildContext context) {
    emblema = ModalRoute.of(context)!.settings.arguments as Emblema;
    carreEmblemasUser();
  }

  carreEmblemasUser() async {
    var ret = await appwriteAdmin.database.listDocuments(
      collectionId: EmblemaUser.collectionId,
      queries: [Query.equal('idEmblema', emblema.id)],
      limit: 100,
    );
    lista = ret.documents.map((e) => EmblemaUser.fromJson(e.data)).toList();
    status.value = StatusBuild.done;
  }

  Future<User> getUser(String id) async {
    var ret = await appwriteAdmin.users.list(search: id);
    return User.fromJson(ret.users.first.toMap());
  }
}
