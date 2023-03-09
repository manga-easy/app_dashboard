enum LevelPermissoes {
  none(value: 0),
  admin(value: 90),
  suporte(value: 60),
  parceiro(value: 40),
  autor(value: 30);

  final int value;
  const LevelPermissoes({required this.value});
}
