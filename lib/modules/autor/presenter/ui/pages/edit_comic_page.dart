import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_comic_controller.dart';
import 'package:flutter/material.dart';

class EditComicPage extends StatefulWidget {
  static const route = '/EditComic';
  const EditComicPage({Key? key}) : super(key: key);
  @override
  State<EditComicPage> createState() => _EditComicPageState();
}

class _EditComicPageState extends State<EditComicPage> {
  final ct = di.get<EditComicController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
