import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                onPress: () => Get.toNamed('/criar.recomendacao'),
              ),
            ],
          ),
          SizedBox(height: AppTheme.defaultPadding),
          Container(
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
                        return Card(
                          color: AppTheme.primaryColor,
                          child: Column(
                            children: [
                              ListTile(
                                textColor: Colors.white,
                                title: Text(
                                    ct.listaRecomendacaoItens[index].nomeManga),
                                subtitle: Text(ct.listaRecomendacaoItens[index]
                                    .descricaoRecomendacao),
                              ),
                              Text(ct.listaRecomendacaoItens[index].link),
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
        ],
      ),
    );
  }
}
