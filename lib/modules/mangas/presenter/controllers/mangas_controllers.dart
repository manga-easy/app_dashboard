import 'dart:io';

import 'package:dashboard_manga_easy/core/interfaces/controller.dart';
import 'package:dashboard_manga_easy/core/services/global.dart';
import 'package:dashboard_manga_easy/modules/configApp/domain/repositories/config_app_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/info_comic_repository_inter.dart';
import 'package:dashboard_manga_easy/modules/mangas/domain/repositories/view_comic_repository_inter.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class MangasController extends IController {
  final IViewComicRepository viewComicRepository;
  final IInforComicRepository infoComicRepository;
  final IConfigAppRepository configAppRepository;
  final Global global;

  MangasController({
    required this.infoComicRepository,
    required this.global,
    required this.viewComicRepository,
    required this.configAppRepository,
  });

  final PagingController<int, InfoComicModel> pagingController = PagingController(firstPageKey: 0);
  String search = '';
  var total = ValueNotifier(0);
  var status = ValueNotifier(StatusBuild.loading);

  @override
  void onClose() {
    status.dispose();
    pagingController.dispose();
  }

  @override
  void onInit(BuildContext context) {
    status.value = StatusBuild.done;
  }

  Future<void> alterIsAdult(InfoComicModel manga) async {
    try {
      status.value = StatusBuild.loading;
      var config = await configAppRepository.get();
      if (manga.isAdult) {
        manga.isAdult = false;
        config.over18List.remove(manga.name);
      } else {
        manga.isAdult = true;
        config.over18List.add(manga.name);
      }
      configAppRepository.update(config);
      infoComicRepository.update(comic: manga);
    } catch (e) {
      Helps.log(e);
    }
    status.value = StatusBuild.done;
  }

  Future<int> carregaViews(String uniqueid) async {
    return await viewComicRepository.total(uniqueid: uniqueid);
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      var ret = await infoComicRepository.list(
        search: search,
        offset: pageKey,
      );
      total.value = ret.total;
      final newItems = ret.data;
      final isLastPage = newItems.length < 25;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      Helps.log(error);
      pagingController.error = error;
    }
  }

  // Future<void> classificAuto() async {
  //   var config = await configAppRepository.get();

  //   for (var i = 0; i < 1000; i++) {
  //     print('offset $i');
  //     var ret = await infoComicRepository.list(
  //       search: '',
  //       offset: i * 100,
  //       gender: 'adult',
  //     );
  //     if (ret.data.isEmpty) {
  //       break;
  //     }

  //     for (var element in ret.data) {
  //       print(element.name);
  //       if (!element.isAdult) {
  //         element.isAdult = true;
  //         config.over18List.add(element.name);
  //         await configAppRepository.update(config);
  //         await infoComicRepository.update(comic: element);
  //       }
  //     }
  //   }
  // }
}
