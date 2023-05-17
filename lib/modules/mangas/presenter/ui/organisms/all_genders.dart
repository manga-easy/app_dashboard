import 'package:coffee_cup/coffe_cup.dart';
import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/molecules/gender_label.dart';
import 'package:flutter/material.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class AllGenders extends StatelessWidget {
  const AllGenders({super.key});

  @override
  Widget build(BuildContext context) {
    final genders = GenerosModel.carregaGeneros();
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          const SizedBox(height: 15),
          const CoffeeText(
            text: 'Selecionar gênero',
            typography: CoffeeTypography.title,
          ),
          const SizedBox(height: 15),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: genders.length,
              itemBuilder: (context, index) {
                final gender = genders[index];
                return GenderLabel(
                  onTap: (String gender) => Navigator.pop(context, gender),
                  gender: gender.codigo,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
