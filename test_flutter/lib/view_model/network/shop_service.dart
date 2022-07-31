import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:test_flutter/models/response_menus.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/models/response_ordered.dart';
import 'package:test_flutter/models/response_status_cancel.dart';
import 'package:test_flutter/models/response_status_ordered.dart';
import 'package:test_flutter/models/response_voucher.dart';
import 'package:test_flutter/utils/constans.dart';

class ShopService {
  static Future<ResponseMenus> getMenus() async {
    final response = await http.get(Uri.parse(BASE_URL + MENU_ENDPOINT));

    if (response.statusCode == SUCCESS) {
      return ResponseMenus.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Menus');
    }
  }

  static Future<ResponseVoucher> postVoucher(String kode) async {
    final response = await http.get(Uri.parse(BASE_URL + VOUCHER + kode));

    if (response.statusCode == SUCCESS) {
      return ResponseVoucher.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Faield to load Voucher');
    }
  }

  static Future<ResponseStatusOrdered> postItemOrdered(
      ResponseOrdered ordered) async {
    final response = await http.post(
      Uri.parse(BASE_URL + ORDER),
      body: jsonEncode(ordered.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == SUCCESS) {
      return ResponseStatusOrdered.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post item');
    }
  }

  static Future<ResponseStatusCancel> cancelOrder(int id) async {
    final response = await http.post(
      Uri.parse(BASE_URL + CANCEL_ORDER + id.toString()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == SUCCESS) {
      return ResponseStatusCancel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to cancel item');
    }
  }
}
