import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/edite_nivel_user.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CardXpUser extends StatelessWidget {
  final UsersDetalhesController ct;
  const CardXpUser({super.key, required this.ct});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nivels',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        ValueListenableBuilder<List<NivelUser>>(
          valueListenable: ct.listXps,
          builder: (context, value, child) {
            return SizedBox(
              height: 300,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: ListView.builder(
                  itemCount: value.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    var nivel = value[index];
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(
                          context,
                          EditeNivelUserPage.route,
                          arguments: nivel,
                        ).then((value) => ct.carregaXpsUser()),
                        title: Text(
                          'Temporada: ${nivel.temporada}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          'Nivel ${nivel.lvl}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
