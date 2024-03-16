import 'dart:io';

import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/repositories/emblemas_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CriaEditaEmblemaController extends IController {
  final EmblemasRepository _emblemasRepository;

  CriaEditaEmblemaController(this._emblemasRepository);

  Emblema? emblema;
  File? image;

  @override
  void init(BuildContext context) {
    emblema = ModalRoute.of(context)!.settings.arguments as Emblema?;
    emblema ??= Emblema.empty();
    state = StatusBuild.done;
  }

  Future<void> criaAlteraEmblema(context) async {
    try {
      state = StatusBuild.loading;
      if (emblema!.id == null) {
        await _emblemasRepository.creatDocument(objeto: emblema!);
      } else {
        await _emblemasRepository.updateDocument(objeto: emblema!);
      }
      Navigator.of(context).pop();
      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Emblema salvo com sucesso',
        context: context,
      );
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
    state = StatusBuild.done;
  }

  void update() => state = StatusBuild.done;

  Future<void> pickerImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        throw Exception('Erro ao selecionar imagem');
      }
      image = File(pickedFile.path);
      await _emblemasRepository.updateImage(file: image!, id: emblema!.id!);
    } on Exception catch (e) {
      handleErrorEvent(e);
    }
  }
}
