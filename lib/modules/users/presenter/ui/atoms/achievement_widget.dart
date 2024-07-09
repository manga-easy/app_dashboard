import 'package:dashboard_manga_easy/modules/emblemas/domain/models/achievement_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AchievementWidget extends StatelessWidget {
  final Future<AchievementEntity?>? future;
  final void Function(BuildContext context) removeIdEmblema;
  final int dateAcquired;

  const AchievementWidget({
    super.key,
    this.future,
    required this.dateAcquired,
    required this.removeIdEmblema,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 70,
            height: 100,
            child: FutureBuilder<AchievementEntity?>(
              future: future,
              builder: (context, snap) {
                if (snap.hasData && snap.data != null) {
                  final achievement = snap.data!;
                  return Column(
                    children: [
                      Image.network(
                        achievement.url,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        achievement.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(
                          DateTime.fromMillisecondsSinceEpoch(dateAcquired),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: () => removeIdEmblema(context),
          child: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
