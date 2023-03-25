class MangaDto {
  final String status;
  final String message;
  final int quant;
  final List<Map<String, dynamic>> data;

  MangaDto({
    required this.status,
    required this.message,
    required this.quant,
    required this.data,
  });

  MangaDto.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        quant = json['quant'],
        data = json['data']
            .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'quant': quant,
      'data': data,
    };
  }
}
