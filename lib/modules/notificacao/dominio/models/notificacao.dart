class Notificacao {
  final String id;
  final String title;
  final String? message;
  final String? image;
  final int createAt;
  final String status;

  Notificacao({
    required this.id,
    required this.message,
    required this.title,
    required this.image,
    required this.createAt,
    required this.status,
  });

  factory Notificacao.fromMap(Map<String, dynamic> map) {
    return Notificacao(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      image: map['image'],
      createAt: map['createdAt'] ?? 0,
      status: map['status'],
    );
  }
}
