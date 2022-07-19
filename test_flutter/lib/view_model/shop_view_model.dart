import 'package:flutter/foundation.dart';
import 'package:test_flutter/models/response_menus.dart';
import 'package:test_flutter/view_model/network/shop_service.dart';

class ShopViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ResponseMenus _menu = ResponseMenus(statusCode: 0, datas: []);

  bool get isLoading => _isLoading;
  ResponseMenus get dataMenu => _menu;

  ShopViewModel() {
    getMenus();
  }

  _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  _setDataMenu(ResponseMenus user) {
    _menu = user;
    notifyListeners();
  }

  void getMenus() async {
    _setIsLoading(true);

    ResponseMenus response = await ShopService.getMenus();

    _setDataMenu(response);

    _setIsLoading(false);
  }
}
