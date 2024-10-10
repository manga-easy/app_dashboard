import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/data/repositories/recommendation_repository.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class RecomendacaoController extends ManagerStore {
  final RecommendationsRepository _recomendationsRepository;

  RecomendacaoController(this._recomendationsRepository);

  var listaRecomendacaoItens = <RecommendationsEntity>[];
  String seach = '';

  @override
  void init(Map<String, dynamic> arguments) {
    listaRecomendacao();
  }

  Future<void> listaRecomendacao() async {
    try {
      state = StateManager.loading;
      listaRecomendacaoItens.clear();
      listaRecomendacaoItens = await _recomendationsRepository.listDocument();
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
      Helps.log(e);
      rethrow;
    }
  }

  Future<void> deleteRecomendacao(RecommendationsEntity entity, context) =>
      handleTry(
        call: () async {
          await _recomendationsRepository.deletDocument(id: entity.id!);
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Recomendação deletada com sucesso',
            context: context,
          );
        },
      );

  void search(String value) {
    seach = value;
    notifyListeners();
  }
}
