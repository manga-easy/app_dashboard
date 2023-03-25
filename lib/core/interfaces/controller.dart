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
}
