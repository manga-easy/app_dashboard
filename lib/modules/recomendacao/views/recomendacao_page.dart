import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/widgets/side_menu.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/views/criar_recomendacao_page.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecomendacaoPage extends StatefulWidget {
  static const route = '/Recomendacao';
  const RecomendacaoPage({Key? key}) : super(key: key);
  @override
  State<RecomendacaoPage> createState() => _RecomendacaoPageState();
}

class _RecomendacaoPageState extends State<RecomendacaoPage> {
  final ct = di.get<RecomendacaoController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
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
      drawer: const SideMenu(atual: RecomendacaoPage.route),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.defaultPadding * 2,
            vertical: AppTheme.defaultPadding * 2,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonPadraoAtom(
                    title: 'Nova recomendação',
                    icone: Icons.add,
                    onPress: () => Navigator.of(context)
                        .pushNamed(CriarRecomendacaoPage.route)
                        .then((value) => ct.listaRecomendacao()),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.defaultPadding),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.secondaryColor,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: ct.listaRecomendacaoItens,
                    builder: (context, value, child) => ct.listaRecomendacaoItens.value.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: ct.listaRecomendacaoItens.value.length,
                            itemBuilder: (context, index) {
                              RecomendacoesModel reco = ct.listaRecomendacaoItens.value[index];
                              return Card(
                                color: AppTheme.primaryColor,
                                child: Column(
                                  children: [
                                    ListTile(
                                      textColor: Colors.white,
                                      title: Text(
                                        reco.title,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Image.network(
                                        reco.link,
                                        height: 300,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ButtonPadraoAtom(
                                          title: "Editar",
                                          icone: Icons.edit,
                                          onPress: () => Navigator.of(context)
                                              .pushNamed(
                                                CriarRecomendacaoPage.route,
                                                arguments: reco,
                                              )
                                              .then((value) => ct.listaRecomendacao()),
                                        ),
                                        ElevatedButton.icon(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                          ),
                                          onPressed: () => ct
                                              .deleteRecomendacao(reco, context)
                                              .then((value) => ct.listaRecomendacao()),
                                          icon: const Icon(Icons.delete_forever),
                                          label: const Text('Deletar'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16)
                                  ],
                                ),
                              );
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
