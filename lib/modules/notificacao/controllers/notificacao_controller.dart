import 'package:api_fcm/api_fcm.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:dashboard_manga_easy/modules/notificacao/views/organisms/form_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class NotificacaoController extends IController {
  final NotificacaoRepository notificacaoRepository;
  final Global global;
  final ApiFcm apiFcm;
  var status = ValueNotifier(StatusBuild.loading);
  var nova = Notificacao(
    menssege: '',
    titulo: '',
    dateMade: DateTime.now().millisecondsSinceEpoch,
    image: '',
  );
  var lista = ValueNotifier(<Notificacao>[]);

  NotificacaoController({required this.notificacaoRepository, required this.global, required this.apiFcm});
  @override
  void onClose() {
    status.dispose();
    lista.dispose();
  }

  @override
  void onInit(BuildContext context) {
    carregaNotificacao();
  }

  void carregaNotificacao() async {
    status.value = StatusBuild.loading;
    lista.value.clear();
    var retorno = await notificacaoRepository.listDocument();
    lista.value = retorno.data;
    status.value = StatusBuild.done;
  }

  void enviaNotificacao(context) async {
    await notificacaoRepository.creatDocument(objeto: nova);
    var ret = await apiFcm.postTopics(
      topics: 'avisos',
      notification: MessageModel(
        body: nova.menssege,
        title: nova.titulo,
        image: nova.image,
      ),
    );

    if (ret.isSend) {
      Navigator.pop(context);
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Mensagem enviada com sucesso',
        context: context,
      );
    } else {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: 'Mensagem não foi enviada',
        context: context,
      );
    }
  }

  void addNotificacao(context) {
    AppHelps.bottomSheet(
      context: context,
      isScrollControlled: true,
      child: FormNotificacao(controller: this),
    );
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
