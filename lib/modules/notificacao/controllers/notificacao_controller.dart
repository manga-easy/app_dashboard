import 'package:dashboard_manga_easy/core/apis/fcm_api.dart';
import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/notificacao/dominio/repositories/notificacao_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class NotificacaoController extends IController {
  final NotificacaoRepository notificacaoRepository;
  final Global global;
  final FCMApi apiFcm;
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
    var noti = await notificacaoRepository.creatDocument(objeto: nova);
    var ret = await apiFcm.postAviso(
      msg: nova.menssege,
      title: nova.titulo,
      idmsg: 'noti.data]',
    );

    if (ret) {
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
      child: Container(
        color: AppTheme.bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Novo Aviso',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            CampoPadraoAtom(
              hintText: 'Digite o titulo',
              onChange: (v) => nova.titulo = v,
            ),
            const SizedBox(height: 10),
            CampoPadraoAtom(
              hintText: 'Digite a mensagem',
              onChange: (v) => nova.menssege = v,
            ),
            const SizedBox(height: 20),
            ButtonPadraoAtom(
              onPress: () => enviaNotificacao(context),
              icone: Icons.send,
              title: "Enviar",
            )
          ],
        ),
      ),
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
