import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_flutter/models/response_menus.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/utils/constans.dart';

class ShopService {
  static Future<ResponseMenus> getMenus() async {
    final response = await http.get(Uri.parse(BASE_URL + MENU_ENDPOINT));

    debugPrint(response.body.toString());
    if (response.statusCode == SUCCESS) {
      return ResponseMenus.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Menus');
    }
  }
}
