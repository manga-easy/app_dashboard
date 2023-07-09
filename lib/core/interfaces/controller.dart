import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/status_build_enum.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

abstract class IController extends ChangeNotifier {
  StatusBuild _state = StatusBuild.initial;
  StatusBuild get state => _state;
  void init(BuildContext context);
  set state(StatusBuild status) {
    try {
      _state = status;
      notifyListeners();
    } catch (e) {
      Helps.log(e);
    }
  }

  void handlerError(e, BuildContext context) {
    String message = 'Ocorreu um erro';
    Helps.log(e);

    if (e is ApiError) {
      message = e.message;
    }
    AppHelps.confirmaDialog(
      title: 'Error ⚠️😥',
      content: message.replaceFirst('Exception:', ''),
      context: context,
    );
  }
}
