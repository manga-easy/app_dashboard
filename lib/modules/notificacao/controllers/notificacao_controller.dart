import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class NotificacaoController extends IController {
  final NotificacaoRepository notificacaoRepository;

  var lista = ValueNotifier(<Notificacao>[]);

  NotificacaoController({
    required this.notificacaoRepository,
  });
  @override
  void dispose() {
    super.dispose();
    lista.dispose();
  }

  @override
  void init(BuildContext context) {
    carregaNotificacao();
  }

  void carregaNotificacao() async {
    state = StatusBuild.loading;
    lista.value.clear();
    var retorno = await notificacaoRepository.listDocument();
    lista.value = retorno.data;
    state = StatusBuild.done;
  }

  Future<void> removePermissoes(String id, context) async {
    var ret = await AppHelps.confirmaDialog(
      title: 'Tem certeza?',
      content: '',
      context: context,
    );
    if (ret) {
      await notificacaoRepository.deletDocument(id: id);
      carregaNotificacao();
    }
  }
}
