import 'package:test_flutter/models/menu.dart';

class ResponseMenus {
  final int statusCode;
  List<Menu> datas;

  ResponseMenus({required this.statusCode, required this.datas});

  factory ResponseMenus.fromJson(Map<String, dynamic> json) {
    return ResponseMenus(
        statusCode: json['status_code'],
        datas: List<Menu>.from(json['datas'].map((item) {
          return Menu.fromJson(item);
        })));
  }
}
