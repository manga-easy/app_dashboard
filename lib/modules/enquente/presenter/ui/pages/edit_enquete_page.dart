import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/enquente/presenter/controllers/edit_enquete_controller.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';
import 'package:uuid/uuid.dart';

class EditEnquetePage extends StatefulWidget {
  static const route = '/EditEnquete';
  const EditEnquetePage({super.key});
  @override
  State<EditEnquetePage> createState() => _EditEnquetePageState();
}

class _EditEnquetePageState extends State<EditEnquetePage> {
  final ct = di.get<EditEnqueteController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ct,
      builder: (context, child) {
        if (ct.enquete == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Enquete'),
          ),
          body: Container(
            margin: const EdgeInsets.all(AppTheme.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.defaultPadding),
              children: [
                CampoPadraoAtom(
                  hintText: 'Pergunta',
                  initialValue: ct.enquete!.name,
                  onChange: (p0) => ct.enquete!.name = p0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                CampoPadraoAtom(
                  hintText: 'Link do banner',
                  initialValue: ct.enquete!.bannerLink,
                  onChange: (p0) => ct.enquete!.bannerLink = p0,
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                Row(
                  children: [
                    Text(
                      'Escolhas',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.defaultPadding * 2),
                  child: Column(
                    children: [
                      const SizedBox(height: AppTheme.defaultPadding / 2),
                      Column(
                        children: beneficios(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              ct.enquete!.questions.add(
                                  Question(id: const Uuid().v4(), name: ''));
                              ct.notifyListeners();
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              ct.enquete!.questions.removeLast();
                              ct.notifyListeners();
                            },
                            icon: const Icon(Icons.remove),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.defaultPadding),
                ButtonPadraoAtom(
                  title: 'Salvar',
                  icone: Icons.create,
                  onPress: () => ct.salvarEditaDados(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> beneficios() {
    var widiget = <Widget>[];
    for (var i = 0; i < ct.enquete!.questions.length; i++) {
      widiget.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CampoPadraoAtom(
            onChange: (p0) => ct.enquete!.questions[i].name = p0,
            initialValue: ct.enquete!.questions[i].name,
          ),
        ),
      );
    }

    return widiget;
  }
}
