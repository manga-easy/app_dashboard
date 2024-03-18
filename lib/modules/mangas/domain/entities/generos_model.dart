class GenerosModel {
  String? id;
  String imagem;
  String titulo;
  String codigo;

  GenerosModel({
    this.id,
    required this.imagem,
    required this.titulo,
    required this.codigo,
  });
  GenerosModel.fromJson(dynamic json)
      : imagem = json['imagem'],
        titulo = json['titulo'],
        codigo = json['codigo'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imagem'] = imagem;
    data['titulo'] = titulo;
    data['codigo'] = codigo;
    return data;
  }

  static List<GenerosModel> carregaGeneros({String? codigo}) {
    final aura = <GenerosModel>[];
    for (var item in generos) {
      if (codigo != null) {
        codigo = codigo
            .replaceAll(' ', '-')
            .toLowerCase()
            .replaceAll('ç', 'c')
            .replaceAll('ã', 'a')
            .replaceAll('é', 'e')
            .replaceAll('ó', 'o');
        if (codigo.toLowerCase().contains(item['codigo']!)) {
          aura.add(GenerosModel.fromJson(item));
        }
      } else {
        aura.add(GenerosModel.fromJson(item));
      }
    }

    aura.sort((a, b) => a.codigo.compareTo(b.codigo));
    return aura;
  }

  static const dc =
      'https://media.discordapp.net/attachments/912814023555301427/';
  static const generos = [
    {
      'imagem':
          '$dc/950093396637266090/PicsArt_12-22-02.30.29.webp?width=663&height=663',
      'titulo': 'Ação',
      'codigo': 'acao',
    },
    {
      'imagem':
          '$dc/947589746979385344/PicsArt_02-27-04.07.23.webp?width=663&height=663',
      'titulo': 'Adulto',
      'codigo': 'adulto',
    },
    {
      'imagem':
          '$dc/938064848711991326/PicsArt_01-31-08.08.52.webp?width=473&height=473',
      'titulo': 'Suspense',
      'codigo': 'suspense',
    },
    {
      'imagem':
          '$dc/938064849055907890/PicsArt_01-31-09.04.26.webp?width=473&height=473',
      'titulo': 'Culinária',
      'codigo': 'culinaria',
    },
    {
      'imagem':
          '$dc/945694883916681226/PicsArt_02-21-12.22.01.webp?width=473&height=473',
      'titulo': 'Harém',
      'codigo': 'harem',
    },
    {
      'imagem':
          '$dc/945694884155768832/PicsArt_02-21-12.21.24.webp?width=473&height=473',
      'titulo': 'Fantasia',
      'codigo': 'fantasia',
    },
    {
      'imagem':
          '$dc/939639801555058749/PicsArt_02-05-05.52.29.webp?width=473&height=473',
      'titulo': 'Poderes',
      'codigo': 'poderes',
    },
    {
      'imagem':
          '$dc/939634544519311460/PicsArt_02-05-05.19.28.webp?width=473&height=473',
      'titulo': 'Magia',
      'codigo': 'magia',
    },
    {
      'imagem':
          '$dc/939634544766763038/PicsArt_02-05-05.20.51.webp?width=473&height=473',
      'titulo': 'Musical',
      'codigo': 'musical',
    },
    {
      'imagem':
          '$dc/939634546083766362/PicsArt_02-05-05.26.09.webp?width=473&height=473',
      'titulo': 'Escolar',
      'codigo': 'escolar',
    },
    {
      'imagem':
          '$dc/939634546373197845/PicsArt_02-05-05.21.46.webp?width=473&height=473',
      'titulo': 'Sobrenatural',
      'codigo': 'sobrenatural',
    },
    {
      'imagem':
          '$dc/939634545119100979/PicsArt_02-05-05.20.31.webp?width=473&height=473',
      'titulo': 'Slice of Life',
      'codigo': 'slice-of-life',
    },
    {
      'imagem':
          '$dc/939634546658390016/PicsArt_02-05-05.21.13.webp?width=473&height=473',
      'titulo': 'Mistério',
      'codigo': 'misterio',
    },
    {
      'imagem':
          '$dc/937564512222056468/PicsArt_01-30-10.58.24_1.webp?width=473&height=473',
      'titulo': 'Mecha',
      'codigo': 'mecha',
    },
    {
      'imagem':
          '$dc/937564512427573258/PicsArt_01-30-11.24.24.webp?width=544&height=544',
      'titulo': 'Ficção Científica',
      'codigo': 'ficcao-cientifica',
    },
    {
      'imagem':
          '$dc/937564512658276413/PicsArt_01-30-10.58.46.webp?width=473&height=473',
      'titulo': 'Histórico',
      'codigo': 'historico',
    },
    {
      'imagem':
          '$dc/937564512868003890/PicsArt_01-30-10.59.49.webp?width=473&height=473',
      'titulo': 'Horror',
      'codigo': 'horror',
    },
    {
      'imagem':
          '$dc/956612135432126494/Picsart_22-03-24_13-52-59-293.webp?width=544&height=544',
      'titulo': '4Koma',
      'codigo': '4koma',
    },
    {
      'imagem':
          '$dc/950095816444485642/PicsArt_01-14-07.40.13-1.webp?width=663&height=663',
      'titulo': 'Artes Marciais',
      'codigo': 'artes-marciais',
    },
    {
      'imagem':
          '$dc/950155112448417872/PicsArt_01-14-07.41.20-3.webp?width=544&height=544',
      'titulo': 'Comédia',
      'codigo': 'comedia',
    },
    {
      'imagem':
          '$dc/956612135683780668/Picsart_22-03-24_13-53-29-075.webp?width=544&height=544',
      'titulo': 'Dementia',
      'codigo': 'dementia',
    },
    {
      'imagem':
          '$dc/961001944623771698/Picsart_22-04-05_16-37-26-942.webp?width=671&height=671',
      'titulo': 'Demônios',
      'codigo': 'demonios',
    },
    {
      'imagem':
          '$dc/950154649112027146/PicsArt_12-26-12.51.24.webp?width=544&height=544',
      'titulo': 'Drama',
      'codigo': 'drama',
    },
    {
      'imagem':
          '$dc/950154604493017119/PicsArt_01-18-05.04.28-1.webp?width=484&height=484',
      'titulo': 'Ecchi',
      'codigo': 'ecchi',
    },
    {
      'imagem':
          '$dc/963907876156502116/Picsart_22-04-13_16-40-37-169.webp?width=671&height=671',
      'titulo': 'Espaço',
      'codigo': 'espaco',
    },
    {
      'imagem':
          '$dc/950154604887302144/PicsArt_12-22-02.23.05.webp?width=663&height=663',
      'titulo': 'Esportes',
      'codigo': 'esportes',
    },
    {
      'imagem':
          '$dc/961001944883789895/Picsart_22-04-05_16-37-07-490.webp?width=671&height=671',
      'titulo': 'Gender Bender',
      'codigo': 'gender-bender',
    },
    {
      'imagem':
          '$dc/963907876563353681/Picsart_22-04-13_17-00-53-632.webp?width=671&height=671',
      'titulo': 'Jogo',
      'codigo': 'jogo',
    },
    {
      'imagem':
          '$dc/950154650550698085/PicsArt_12-20-11.55.35.webp?width=663&height=663',
      'titulo': 'Josei',
      'codigo': 'josei',
    },
    {
      'imagem':
          '$dc/963907876856946748/Picsart_22-04-13_16-37-28-345.webp?width=671&height=671',
      'titulo': 'Militar',
      'codigo': 'militar',
    },
    {
      'imagem':
          '$dc/963920715160105010/Picsart_22-04-13_17-52-24-603-_1.webp?width=671&height=671',
      'titulo': 'Nonsense',
      'codigo': 'nonsense',
    },
    {
      'imagem':
          '$dc/950154604698533949/PicsArt_01-14-07.38.47-1.webp?width=663&height=663',
      'titulo': 'Paródia',
      'codigo': 'parodia',
    },
    {
      'imagem':
          '$dc/968366282569293874/Picsart_22-04-25_20-20-17-420.webp?width=672&height=671',
      'titulo': 'Policial',
      'codigo': 'policial',
    },
    {
      'imagem': '$dc/958832780748410941/Psicologico.png?width=544&height=544',
      'titulo': 'Psicológico',
      'codigo': 'psicologico',
    },
    {
      'imagem':
          '$dc/950154649867010088/PicsArt_12-20-11.57.34.webp?width=544&height=544',
      'titulo': 'Romance',
      'codigo': 'romance',
    },
    {
      'imagem':
          '$dc/968366282913234984/Picsart_22-04-24_15-50-36-232.webp?width=671&height=671',
      'titulo': 'Samurai',
      'codigo': 'samurai',
    },
    {
      'imagem':
          '$dc/950154649581801622/PicsArt_12-20-11.58.42.webp?width=544&height=544',
      'titulo': 'Seinen',
      'codigo': 'seinen',
    },
    {
      'imagem': '$dc/958831012958310440/shoujo.webp?width=544&height=544',
      'titulo': 'Shoujo',
      'codigo': 'shoujo',
    },
    {
      'imagem':
          '$dc/939634545366552576/PicsArt_02-05-05.20.09.webp?width=663&height=663',
      'titulo': 'Shoujo Ai',
      'codigo': 'shoujo-ai',
    },
    {
      'imagem': '$dc/958830564004208710/shounen.webp?width=544&height=544',
      'titulo': 'Shounen',
      'codigo': 'shounen',
    },
    {
      'imagem':
          '$dc/947589538589581322/PicsArt_02-27-04.20.59.webp?width=544&height=544',
      'titulo': 'Shounen Ai',
      'codigo': 'shounen-ai',
    },
    {
      'imagem':
          '$dc/968366282300862464/Picsart_22-04-25_23-12-15-283.webp?width=673&height=671',
      'titulo': 'Vampiros',
      'codigo': 'vampiros',
    },
    {
      'imagem':
          '$dc/950095816188649522/PicsArt_01-14-07.39.55-2.webp?width=663&height=663',
      'titulo': 'Aventura',
      'codigo': 'aventura',
    },
    {
      'imagem':
          '$dc/950154650127040522/PicsArt_12-20-11.55.50.webp?width=544&height=544',
      'titulo': 'Yaoi',
      'codigo': 'yaoi',
    },
    {
      'imagem':
          '$dc/968366282019835905/Picsart_22-04-26_00-13-22-775.webp?width=671&height=671',
      'titulo': 'Yuri',
      'codigo': 'yuri',
    }
  ];
}
