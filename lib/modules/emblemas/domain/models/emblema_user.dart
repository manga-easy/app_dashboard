class EmblemaUser {
  String? id;
  String idEmblema;
  @Deprecated('Use createAt ou updateAt. 0.13.0 to 0.15.0')
  int timeCria;
  String userId;
  int createAt;
  int updateAt;

  EmblemaUser({
    this.id,
    required this.timeCria,
    required this.userId,
    required this.idEmblema,
    required this.createAt,
    required this.updateAt,
  });
}
