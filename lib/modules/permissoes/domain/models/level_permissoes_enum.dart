enum LevelPermissoes {
  none(value: 0),
  admin(value: 90),
  parceiro(value: 40),
  autor(value: 30),
  root(value: 100);

  final int value;
  const LevelPermissoes({required this.value});
}
