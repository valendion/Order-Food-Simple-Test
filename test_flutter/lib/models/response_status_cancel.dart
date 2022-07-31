class ResponseStatusCancel {
  int statusCode;
  String message;

  ResponseStatusCancel({required this.message, required this.statusCode});

  factory ResponseStatusCancel.fromJson(Map<String, dynamic> json) {
    return ResponseStatusCancel(
        message: json['message'], statusCode: json['status_code']);
  }
}
