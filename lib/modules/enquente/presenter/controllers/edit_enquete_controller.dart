import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/auth/domain/repo/user_repository_external.dart';
import 'package:dashboard_manga_easy/modules/enquente/domain/repositories/enquete_repository.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EditEnqueteController extends ValueNotifier implements IController {
  final UserRepositoryExternal userRepo;
  final EnqueteRepository permissoesRepository;
  EnqueteModel? enquete;
  EditEnqueteController({
    required this.permissoesRepository,
    required this.userRepo,
  }) : super(null);

  @override
  void onClose() {
    dispose();
  }

  @override
  void onInit(BuildContext context) {
    enquete = ModalRoute.of(context)!.settings.arguments as EnqueteModel?;
    enquete ??= EnqueteModel(
      createDate: DateTime.now().millisecondsSinceEpoch,
      name: '',
      questions: [],
      status: EnqueteStatus.started,
      finishedDate: null,
    );
    notifyListeners();
  }

  Future<void> salvarEditaDados(BuildContext context) async {
    try {
      var op = 'criado';
      if (enquete!.questions.isEmpty) {
        throw Exception('Escolhas não pode ser vazia');
      }
      if (enquete!.id == null) {
        await permissoesRepository.creatDocument(objeto: enquete!);
      } else {
        await permissoesRepository.updateDocument(objeto: enquete!);
        op = 'atualizado';
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Enquete $op com sucesso',
        context: context,
      );
    } catch (e) {
      AppHelps.confirmaDialog(
        title: 'Erro',
        content: e.toString(),
        context: context,
      );
      Helps.log(e);
    }
  }

  Future<List<User>> pesquisaUser(String pesquisa) async {
    return await userRepo.list(search: pesquisa);
  }
}
