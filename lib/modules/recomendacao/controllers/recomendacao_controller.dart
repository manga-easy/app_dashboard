import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:flutter/material.dart';

class RecomendacaoController extends IController {
  final RecommendationsRepository _recomendationsRepository;

  RecomendacaoController(this._recomendationsRepository);

  var listaRecomendacaoItens = <RecomendacoesModel>[];

  @override
  void init(BuildContext context) {
    listaRecomendacao();
  }

  Future<void> listaRecomendacao() async {
    state = StatusBuild.loading;
    listaRecomendacaoItens.clear();
    try {
      listaRecomendacaoItens = await _recomendationsRepository.listDocument();
      state = StatusBuild.done;
    } catch (e) {
      state = StatusBuild.erro;
      Helps.log(e);
    }
  }

  Future<void> deleteRecomendacao(RecomendacoesModel entity, context) async {
    try {
      await _recomendationsRepository.deletDocument(id: entity.id!);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Recomendação deletada com sucesso',
        context: context,
      );
    } catch (e) {
      handlerError(e, context);
    }
  }
}
