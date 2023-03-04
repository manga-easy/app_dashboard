import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/service_route.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/chapter_authoral_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/models/comic_model.dart';
import 'package:dashboard_manga_easy/modules/autor/domain/repositories/comic_repository.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class EditComicAuthorialController extends ValueNotifier
    implements IController {
  final ServiceRoute serviceRoute;
  final ComicAuthorialRepository comicAuthorialRepository;
  ComicAuthorialModel? comic;

  EditComicAuthorialController(
      {required this.comicAuthorialRepository, required this.serviceRoute})
      : super(null);

  @override
  void init(BuildContext context) {
    comic = ModalRoute.of(context)!.settings.arguments as ComicAuthorialModel?;
    comic ??= ComicAuthorialModel(
      autor: '',
      chapter: [],
      cover: '',
      scans: '',
      sinopse: '',
      status: true,
      title: '',
      uniqueid: '',
      yearUp: 0,
      idUser: serviceRoute.user!.id!,
      createAt: 'now()',
      updateAt: 'now()',
    );
    notifyListeners();
  }

  Future<void> salvarComic(BuildContext context) async {
    try {
      if (comic!.title.isEmpty) {
        throw Exception('Titulo não pode ta vazio');
      }
      if (comic!.id == null) {
        comic!.uniqueid = Helps.convertUniqueid(comic!.title);
        comic!.autor = serviceRoute.user!.name;
        comic!.scans = 'Easy Originals';
        await comicAuthorialRepository.create(objeto: comic!);
      } else {
        await comicAuthorialRepository.update(objeto: comic!);
      }
      Navigator.of(context).pop();

      AppHelps.confirmaDialog(
        title: 'Sucesso',
        content: 'Obra salva com sucesso',
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
    notifyListeners();
  }

  Future<List<ChapterAuthorial>> getComic() async {
    if (comic?.id == null) {
      return [];
    }
    var ret = await comicAuthorialRepository.get(id: comic!.id!);
    return ret!.chapter;
  }
}
