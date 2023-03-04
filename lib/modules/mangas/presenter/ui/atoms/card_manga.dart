
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:octo_image/octo_image.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class CardManga extends StatelessWidget {
  final InfoComicModel manga;
  final Future<void> Function(InfoComicModel manga) alterIsAdult;
  final Future<int> Function(String uniqueid) loadingViews;

  const CardManga({
    super.key,
    required this.manga,
    required this.loadingViews,
    required this.alterIsAdult,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //direction: Axis.horizontal,
          children: [
            OctoImage(
              width: 100,
              height: 150,
              image:
                  NetworkImage(manga.thumb, headers: Map.from(Global.header)),
              placeholderBuilder: OctoPlaceholder.blurHash(
                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              errorBuilder: OctoError.icon(
                color: Colors.red,
              ),
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: manga.name));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copiado com sucesso'),
                      ));
                    },
                    child: Text(
                      manga.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ratio: ${manga.ratio}'),
                      IconButton(
                        onPressed: () => alterIsAdult(manga),
                        icon: Icon(
                          Icons.no_adult_content,
                          color: manga.isAdult ? Colors.red : null,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text('Ultimo capítulo: ${manga.ultimoCap}'),
                  const SizedBox(height: 5),
                  Text('Views: ${manga.totalViews}'),
                  const SizedBox(height: 5),
                  Wrap(
                    children: manga.generos
                        .split('<>')
                        .map(
                          (e) => Chip(
                            label: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
