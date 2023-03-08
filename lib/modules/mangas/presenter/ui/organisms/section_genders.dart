import 'package:flutter/material.dart';

class SectionGenders extends StatelessWidget {
  final List<String> genders;
  const SectionGenders({super.key, required this.genders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Generos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () => null,
              child: const Text('Adicionar'),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            itemCount: genders.length,
            itemBuilder: (context, index) {
              var gender = genders[index];
              return Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Center(
                  child: Text(
                    gender,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
