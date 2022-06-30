import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/appwrite_client.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriarRecomendacaoController extends ValueNotifier implements IController {
  final AppwriteClient app;
  final Global global;
  RecomendacoesModel? recomendacao;
  CriarRecomendacaoController({
    required this.app,
    required this.global,
  }) : super(null);

  @override
  void onClose() {}

  @override
  void onInit(BuildContext context) {
    recomendacao = ModalRoute.of(context)!.settings.arguments as RecomendacoesModel?;
    recomendacao ??= RecomendacoesModel(
      dataCria: DateTime.now().millisecondsSinceEpoch,
      link: '',
      title: '',
      uniqueid: '',
    );
    notifyListeners();
  }

  void criarRecomendacao(context) async {
    try {
      if (recomendacao!.id == null) {
        if (await verificaExisteRecomendacao(recomendacao!.uniqueid)) {
          Navigator.of(context).pop();
          AppHelps.confirmaDialog(
            title: 'Erro',
            content: 'Recomendação já foi feita, edite a recomenção anterior do mangá',
            context: context,
          );
          return;
        }
        await app.database.createDocument(
          collectionId: RecomendacoesModel.collectionID,
          documentId: 'unique()',
          data: recomendacao!.toJson(),
          read: ['role:all'],
          write: ['role:all'],
        );
      } else {
        await app.database.updateDocument(
          collectionId: RecomendacoesModel.collectionID,
          documentId: recomendacao!.id!,
          data: recomendacao!.toJson(),
        );
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Recomendação salv com sucesso',
        context: context,
      );
    } catch (e) {
      Helps.log(e);
    }
  }

  Future<bool> verificaExisteRecomendacao(String uniqueid) async {
    var ret = await app.database.listDocuments(
      collectionId: RecomendacoesModel.collectionID,
      queries: [Query.equal('uniqueid', uniqueid)],
    );
    return ret.documents.isNotEmpty;
  }
}
