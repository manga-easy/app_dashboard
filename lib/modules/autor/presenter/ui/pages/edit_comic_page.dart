import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/autor/presenter/controllers/edit_comic_controller.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Comic'),
      ),
      body: Container(
        margin: const EdgeInsets.all(AppTheme.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder(
          valueListenable: ct,
          builder: (context, value, child) {
            if (ct.comic == null) return const LoadingAtom();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding),
              children: [
                CampoPadraoAtom(
                  hintText: 'Titulo',
                  initialValue: ct.comic!.title,
                  onChange: (p0) => ct.comic!.title = p0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  hintText: 'Sinopse',
                  initialValue: ct.comic!.sinopse,
                  onChange: (p0) => ct.comic!.sinopse = p0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  hintText: 'Link da capa',
                  initialValue: ct.comic!.cover,
                  onChange: (p0) => ct.comic!.cover = p0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  hintText: 'Ano',
                  initialValue: ct.comic!.yearUp.toString(),
                  onChange: (p0) => ct.comic!.yearUp = int.tryParse(p0) ?? 0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar',
                  icone: Icons.create,
                  onPress: () => null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
