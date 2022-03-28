import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/main/views/widgets/button_padrao.dart';
import 'package:dashboard_manga_easy/modules/recomendacao/controllers/recomendacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                onPress: () {},
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
            child: Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppTheme.primaryColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(index.toString()),
                        ),
                        Text('skdfbsdsdjnsdjvksvjvsdvsdvsdvsdvfbxbfbd'),
                        Image.asset(''),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
