class RecomendacoesModel {
  final String? id;
  final String uniqueid;
  final String title;
  final String link;
  final int createdAt;
  final int updatedAt;
  final String? artistId;
  final String? artistName;

  RecomendacoesModel({
    this.id,
    required this.title,
    required this.link,
    required this.uniqueid,
    required this.createdAt,
    required this.updatedAt,
    this.artistId,
    this.artistName,
  });

  factory RecomendacoesModel.empty() {
    return RecomendacoesModel(
      title: '',
      link: '',
      uniqueid: 'uniqueid',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  RecomendacoesModel copyWith({
    String? id,
    String? uniqueid,
    String? title,
    String? link,
    int? dataCria,
    int? createdAt,
    int? updatedAt,
    String? artistId,
    String? artistName,
  }) {
    return RecomendacoesModel(
      id: id ?? this.id,
      uniqueid: uniqueid ?? this.uniqueid,
      title: title ?? this.title,
      link: link ?? this.link,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
    );
  }
}
