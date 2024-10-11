import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/update_notes/data/dtos/update_notes_dto.dart';
import 'package:dashboard_manga_easy/modules/update_notes/data/repositories/update_notes_repository.dart';
import 'package:dashboard_manga_easy/modules/update_notes/domain/update_notes_entity.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/export_manager.dart';

class UpdateNotesController extends ManagerStore {
  final UpdateNotesRepository _repository;

  UpdateNotesDto? releaseNotesDto;
  var listAllVersions = <UpdateNotesEntity>[];
  String? releasesId;

  UpdateNotesController(this._repository);

  @override
  Future<void> init(Map<String, dynamic> arguments) async {
    releasesId = arguments['id'];

    if (releasesId != null && releasesId != 'create') {
      final result = await _repository.getById(id: releasesId!);
      releaseNotesDto = result;
    } else {
      await listAllVersion();
    }

    state = StateManager.done;
  }

  void invalidValue(String value, BuildContext context) {
    AppHelps.bottomSheet(
      context: context,
      child: Text('Campo $value não pode ser vazio!'),
    );
  }

  Future<void> createRelease(context) => handleTry(
        call: () async {
          if (releasesId == 'create') {
            await _repository.post(body: releaseNotesDto!);
            Navigator.pop(context);
          }
        },
      );

  Future<void> deleteRelease(context) => handleTry(
        call: () async {
          await AppHelps.confirmaDialog(
            title: 'Deseja excluir?',
            context: context,
            confime: () {
              _repository.delete(id: releasesId!);
              Navigator.pop(context);
            },
          );
        },
      );

  Future<void> updateRelease(context) => handleTry(
        call: () async {
          if (releasesId != 'create') {
            await _repository.put(id: releasesId!, body: releaseNotesDto!);
            Navigator.pop(context);
          }
        },
      );

  Future<void> listAllVersion() => handleTry(
        call: () async => {
          listAllVersions = await _repository.get(),
        },
      );
}
