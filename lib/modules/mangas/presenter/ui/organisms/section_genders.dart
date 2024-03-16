import 'package:dashboard_manga_easy/modules/mangas/presenter/ui/molecules/gender_label.dart';
import 'package:flutter/material.dart';

class SectionGenders extends StatelessWidget {
  final void Function()? onAdd;
  final void Function(String gender) onRemove;
  final List<String> genders;
  const SectionGenders({
    super.key,
    required this.genders,
    this.onAdd,
    required this.onRemove,
  });

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
              onPressed: onAdd,
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
              final gender = genders[index];
              return GenderLabel(
                gender: gender,
                onRemove: onRemove,
              );
            },
          ),
        ),
      ],
    );
  }
}
