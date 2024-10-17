import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user_achievement_entity.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/controllers/detalhes_users_controller.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/atoms/achievement_widget.dart';
import 'package:dashboard_manga_easy/modules/users/presenter/ui/organisms/select_dados.dart';
import 'package:flutter/material.dart';

class EmblemasUsersW extends StatelessWidget {
  final UsersDetalhesController ct;
  final List<UserAchievement> list;

  const EmblemasUsersW({super.key, required this.list, required this.ct});

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
                final ret = await AppHelps.bottomSheet(
                  context: context,
                  child: SelectDados<AchievementEntity>(
                    future: ct.loadAchievements,
                    getSubTitle: (v) => v.category.name,
                    getTitle: (v) => v.name,
                  ),
                );
                if (ret is AchievementEntity) {
                  await ct.addEmblema(ret.id);
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final userEmblema = list[index];
                return AchievementWidget(
                  future: ct.getAchievement(userEmblema.achievementId),
                  dateAcquired: userEmblema.createdAt,
                  removeIdEmblema: (context) =>
                      ct.removerEmblema(userEmblema.achievementId, context),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
