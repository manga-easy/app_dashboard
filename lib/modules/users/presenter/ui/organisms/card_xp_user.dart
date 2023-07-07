import 'package:coffee_cup/coffe_cup.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/pages/edite_nivel_user.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CardXpUser extends StatelessWidget {
  final UsersDetalhesController ct;
  const CardXpUser({super.key, required this.ct});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoffeeText(
          text: 'Nivels',
          typography: CoffeeTypography.title,
        ),
        const SizedBox(height: 5),
        ValueListenableBuilder<List<NivelUser>>(
          valueListenable: ct.listXps,
          builder: (context, value, child) {
            return SizedBox(
              height: 300,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: ListView.builder(
                  itemCount: value.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final nivel = value[index];
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(
                          context,
                          EditeNivelUserPage.route,
                          arguments: nivel,
                        ).then((value) => ct.carregaXpsUser()),
                        title: CoffeeText(
                          text: 'Temporada: ${nivel.temporada}',
                        ),
                        subtitle: CoffeeText(
                          text: 'Nivel ${nivel.lvl}',
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
