import 'dart:io';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CriarRecomendacaoController extends IController {
  final RecommendationsRepository _recomendationsRepository;
  final UsersRepository _usersRepository;

  CriarRecomendacaoController(
    this._recomendationsRepository,
    this._usersRepository,
  );

  RecomendacoesModel? recomendacao;
  @override
  void init(BuildContext context) {
    recomendacao =
        ModalRoute.of(context)!.settings.arguments as RecomendacoesModel?;
    recomendacao ??= RecomendacoesModel.empty();
    state = StatusBuild.done;
  }

  Future<void> criarRecomendacao(context) async {
    try {
      if (recomendacao!.id == null) {
        await _recomendationsRepository.creatDocument(objeto: recomendacao!);
      } else {
        await _recomendationsRepository.updateDocument(objeto: recomendacao!);
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Recomendação salva com sucesso',
        context: context,
      );
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
  }

  Future<List<User>> pesquisaUser(String search) async {
    if (search.isEmpty) {
      return [];
    }
    return await _usersRepository.listDocument(
      search: search,
    );
  }

  Future<String> getNameUser({required String userId}) async {
    if (userId.isEmpty) {
      return 'Selecione um usuario';
    }
    final result = await _usersRepository.getDocument(id: userId);
    return '${result?.name} - ${result?.email}';
  }

  Future<void> pickerImage(context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        throw Exception('Erro ao selecionar imagem');
      }
      final image = File(pickedFile.path);
      await _recomendationsRepository.updateImage(
        file: image,
        uniqueid: recomendacao!.uniqueid,
      );
      Navigator.of(context).pop();
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
  }
}
