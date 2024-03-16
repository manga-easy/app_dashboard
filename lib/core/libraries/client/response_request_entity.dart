class ResponseRequestEntity {
  /// Response body..
  final Map<String, dynamic> data;

  /// HTTP status code.
  final int statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  final String statusMessage;

  ResponseRequestEntity({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
  });
}
