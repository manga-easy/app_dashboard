import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class MangaMapper {
  InfoComicModel from(Map<String, dynamic> json) {
    return InfoComicModel(
      name: json['name'],
      id: json['_uid'],
      uniqueid: json['uniqueid'],
      lastcap: json['ultimo_cap'] ?? json['last_cap'],
      totalViews: int.tryParse('${json['total_views']}') ?? 0,
      author: json['author'] ?? json['autor'],
      thumb: json['thumb'],
      synopsis: json['synopsis'] ?? json['sinopse'],
      ratio: double.tryParse('${json['ratio']}') ?? 0.0,
      scans: json['scans'],
      updatedAt: int.tryParse('${json['updated_at']}') ?? 0,
      createdAt: int.tryParse('${json['created_at']}') ?? 0,
      genres: json['genders'] ?? json['generos'],
      year: json['year'] ?? 2099,
    );
  }

  Map<String, dynamic> toJson(InfoComicModel catalog) {
    return {
      'name': catalog.name,
      '_uid': catalog.id,
      'uniqueid': catalog.uniqueid,
      'last_cap': catalog.lastcap,
      'total_views': catalog.totalViews,
      'author': catalog.author,
      'thumb': catalog.thumb,
      'synopsis': catalog.synopsis,
      'ratio': catalog.ratio,
      'scans': catalog.scans,
      'updated_at': catalog.updatedAt,
      'created_at': catalog.createdAt,
      'genres': catalog.genres,
      'year': catalog.year,
    };
  }
}
