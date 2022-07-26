import 'package:flutter/foundation.dart';
import 'package:test_flutter/models/response_menus.dart';
import 'package:test_flutter/models/response_voucher.dart';
import 'package:test_flutter/view_model/network/shop_service.dart';

class ShopViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool _isInputVoucher = false;

  bool _isOrdered = false;

  int _voucherNominal = 0;

  String _kodeVoucher = '';

  ResponseMenus _menu = ResponseMenus(statusCode: 0, datas: []);

  ResponseVoucher _voucher = ResponseVoucher(
      statusCode: 0, datas: Voucher(id: 0, kode: '', nominal: 0));

  bool get isLoading => _isLoading;
  bool get isInputVoucher => _isInputVoucher;
  bool get isOrdered => _isOrdered;
  String get kodeVoucher => _kodeVoucher;
  int? get voucherNominal => _voucherNominal;

  ResponseMenus get dataMenu => _menu;
  ResponseVoucher get dataVoucher => _voucher;

  ShopViewModel() {
    getMenus();
  }

  _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  _setIsInputVoucher(bool isInputVouhcer) {
    _isInputVoucher = isInputVouhcer;
    notifyListeners();
  }

  _setDataMenu(ResponseMenus user) {
    _menu = user;
    notifyListeners();
  }

  _setDataVoucher(ResponseVoucher responseVoucher) {
    _voucher = responseVoucher;
    _setVoucherNominal(responseVoucher.datas.nominal);
    _setkodeVoucher(responseVoucher.datas.kode);
    _setIsInputVoucher(true);
    notifyListeners();
  }

  _setVoucherNominal(int nominal) {
    _voucherNominal = nominal;
    notifyListeners();
  }

  _setkodeVoucher(String kodeVoucher) {
    _kodeVoucher = kodeVoucher;
    notifyListeners();
  }

  setOrdered(bool isOrdered) {
    _isOrdered = isOrdered;
    notifyListeners();
  }

  void getMenus() async {
    _setIsLoading(true);

    ResponseMenus response = await ShopService.getMenus();

    _setDataMenu(response);

    _setIsLoading(false);
  }

  void getVoucher(String kode) async {
    _setIsLoading(true);

    ResponseVoucher response = await ShopService.postVoucher(kode);

    _setDataVoucher(response);

    _setIsLoading(false);
  }
}
