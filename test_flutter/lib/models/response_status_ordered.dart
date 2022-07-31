class ResponseStatusOrdered {
  int id;
  int statusCode;
  String message;

  ResponseStatusOrdered(
      {required this.id, required this.message, required this.statusCode});

  factory ResponseStatusOrdered.fromJson(Map<String, dynamic> json) {
    return ResponseStatusOrdered(
        id: json['id'],
        message: json['message'],
        statusCode: json['status_code']);
  }
}
