enum KeyPreferences {
  ///Ordenaçao dos capitulos do manga
  chapterOrderPrefs(key: 'chapterOrderPrefs'),

  ///Animação do Corrossel do banner
  isAnimatedBanner(key: 'isAnimatedBanner', defaultValue: true),
  //Responsavel por pausar todos downloads dos mangas
  downloadPauseAll(key: 'downloadPauseAll', defaultValue: false),

  ///Responsavel por setar a pasta que vai ser baixada os download
  downloadFolder(key: 'downloadFolder'),
  isShowWarningDownload(key: 'isShowWarningDownload'),

  /// marca se deve exibir a introdução
  isBetaSearch(key: 'isBetaSearch'),

  /// marca se deve exibir a introdução
  isIntruce(key: 'isIntruce'),

  /// salva o objeto blocklist que contem a lista de mangas bloqueado e +18
  blockList(key: 'blockList'),

  ///salva as iniciais do avatar do usuario
  avatar(key: 'avatar'),

  ///dados da config atual do app
  configApp(key: 'ConfigApp'),

  /// dia da ultima sugestão que foi enviada do app em int
  sugestao(key: 'sugestao'),

  /// token de fcm usado para notificação
  tonkenFcm(key: 'tonkenFcm'),

  ///Salvar o usuario logado
  user(key: 'user'),

  ///versão atual do banco local.
  versionDatabase(key: 'versionDatabase', defaultValue: '1.0'),

  /// indica se o filtro de obras +18 está ativo
  filterContentOver18(
    key: 'filterContentOver18',
    defaultValue: true,
  ),

  ///mostrar aviso de mostra opção leitor
  mostraAvisoLeitor(key: 'mostraAvisoLeitor', defaultValue: true),

  /// inverte a listagem capitulos no manga
  invertCapitulos(key: 'invertCapitulos'),

  /// data da ultima ADS em timestaimp
  ultimaADS(key: 'ultimaADS'),

  /// data da ultima sincronização em timestaimp
  ultimaSincronizacao(
    key: 'ultimaSincronizacao',
    defaultValue: '',
  ),

  /// salva a pagina de onde parou nos capitulos
  salvePag(key: 'spc'),

  /// Preferencias do usuario na pagina de leitura do manga
  mangaReadPrefs(key: 'mangaPagePrefs'),

  /// Muda o layout da pesquisa avançada
  selectLayoutSearch(key: 'selectLayoutSearch', defaultValue: false),

  /// Histórico da pesquisa avançada
  searchHistory(key: 'searchHistory', defaultValue: []),

  /// indice do tema atual em int
  theme(key: 'themeApp', defaultValue: 0),

  /// verifica se é a primeira vez que o usuário abre a tela de biblioteca
  isFirstLibrary(key: 'isFirstLibrary', defaultValue: true);

  final String key;
  final dynamic defaultValue;

  const KeyPreferences({required this.key, this.defaultValue});
}
