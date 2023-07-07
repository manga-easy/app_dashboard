import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recommendations_filter.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';

import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CriarRecomendacaoController extends IController {
  final RecommendationsRepository _recomendationsRepository;

  CriarRecomendacaoController(this._recomendationsRepository);

  RecomendacoesModel? recomendacao;
  @override
  void init(BuildContext context) {
    recomendacao =
        ModalRoute.of(context)!.settings.arguments as RecomendacoesModel?;
    recomendacao ??= RecomendacoesModel.empty();
    notifyListeners();
  }

  Future<void> criarRecomendacao(context) async {
    try {
      if (recomendacao!.id == null) {
        if (await verificaExisteRecomendacao(recomendacao!.uniqueid)) {
          Navigator.of(context).pop();
          AppHelps.confirmaDialog(
            title: 'Erro',
            content:
                'Recomendação já foi feita, edite a recomenção anterior do mangá',
            context: context,
          );
          return;
        }
        await _recomendationsRepository.creatDocument(objeto: recomendacao!);
      } else {
        await _recomendationsRepository.updateDocument(objeto: recomendacao!);
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
    final ret = await _recomendationsRepository.listDocument(
      filter: RecommendationsFilter(uniqueid: uniqueid),
    );
    return ret.isNotEmpty;
  }
}
