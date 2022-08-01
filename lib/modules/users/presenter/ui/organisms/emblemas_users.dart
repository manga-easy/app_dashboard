import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/select_dados.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class EmblemasUsersW extends StatelessWidget {
  final UsersDetalhesController ct;
  final List<EmblemaUser> list;

  const EmblemasUsersW({Key? key, required this.list, required this.ct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Emblemas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () async {
                var ret = await AppHelps.bottomSheet(
                  context: context,
                  child: SelectDados<Emblema>(
                    future: ct.carregaEmblemas,
                    getSubTitle: (v) => v.categoria,
                    getTitle: (v) => v.name,
                  ),
                );
                if (ret is Emblema) {
                  ct.addEmblema(ret.id!, context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 140,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                var userEmblema = list[index];
                var emb = ct.listEmblema.firstWhere((element) => element.id == userEmblema.idEmblema);
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            emb.url,
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            emb.name,
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(
                              DateTime.fromMillisecondsSinceEpoch(userEmblema.timeCria),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => ct.removerEmblema(userEmblema.id!, context),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
