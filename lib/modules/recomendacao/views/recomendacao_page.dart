import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class RecomendacaoPage extends GetView {
  final ct = Get.put(RecomendacaoController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.defaultPadding * 2,
        vertical: AppTheme.defaultPadding * 2,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ButtonPadrao(
                title: 'Nova recomendação',
                icone: Icons.add,
                onPress: () => Get.toNamed('/criar.recomendacao')!.then(
                  (value) => ct.listaRecomendacao(),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.defaultPadding),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(AppTheme.defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.secondaryColor,
              ),
              child: Obx(
                () => ct.listaRecomendacaoItens.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: ct.listaRecomendacaoItens.length,
                        itemBuilder: (context, index) {
                          RecomendacoesModel reco = ct.listaRecomendacaoItens[index];
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
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ButtonPadrao(title: "Editar", icone: Icons.edit, onPress: () {}),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(Icons.delete_forever),
                                      label: Text('Deletar'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16)
                              ],
                            ),
                          );
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
