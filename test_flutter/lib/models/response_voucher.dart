class ResponseVoucher {
  int statusCode;
  Voucher datas;

  ResponseVoucher({required this.statusCode, required this.datas});

  factory ResponseVoucher.fromJson(Map<String, dynamic> json) {
    return ResponseVoucher(
        statusCode: json['status_code'],
        datas: Voucher.fromJson(json['datas']));
  }
}

class Voucher {
  int id;
  String kode;
  int nominal;

  Voucher({required this.id, required this.kode, required this.nominal});

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
        id: json['id'], kode: json['kode'], nominal: json['nominal']);
  }
}
