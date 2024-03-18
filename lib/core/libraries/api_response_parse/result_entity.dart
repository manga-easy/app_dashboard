class ResultEntity {
  final String status;
  final String message;
  final int total;
  final List<Map<String, dynamic>> data;

  ResultEntity({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  ResultEntity.fromJson(Map<String, dynamic> map)
      : total = map['total'] ?? map['quant'],
        status = map['status'],
        data = (map['data'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList(),
        message = map['message'];
}
