import 'dart:io';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/entities/recomendacoes_model.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/domain/repositories/recommendation_repository.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class CriarRecomendacaoController extends ManagerStore {
  final RecommendationsRepository _recomendationsRepository;
  final UsersRepository _usersRepository;

  CriarRecomendacaoController(
    this._recomendationsRepository,
    this._usersRepository,
  );

  RecommendationsEntity? recomendacao;
  @override
  void init(Map<String, dynamic> arguments) => handleTry(
        call: () async {
          final recommendationId = arguments['id'];
          recomendacao = await _recomendationsRepository.getDocument(
            id: recommendationId,
          );
          recomendacao ??= RecommendationsEntity.empty();
          state = StateManager.done;
        },
      );

  Future<void> criarRecomendacao(context) => handleTry(
        call: () async {
          if (recomendacao!.id == null) {
            await _recomendationsRepository.creatDocument(
              objeto: recomendacao!,
            );
          } else {
            await _recomendationsRepository.updateDocument(
              objeto: recomendacao!,
            );
          }
          Navigator.of(context).pop();
          AppHelps.confirmaDialog(
            title: 'Sucesso',
            content: 'Recomendação salva com sucesso',
            context: context,
          );
        },
      );

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

  Future<void> pickerImage(context) => handleTry(
        call: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);

          if (pickedFile == null) {
            throw Exception('Erro ao selecionar imagem');
          }
          final image = File(pickedFile.path);
          await _recomendationsRepository.updateImage(
            file: image,
            id: recomendacao!.id!,
          );
          Navigator.of(context).pop();
        },
      );
}
