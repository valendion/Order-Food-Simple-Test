import 'package:flutter/foundation.dart';
import 'package:test_flutter/models/response_menus.dart';
import 'package:test_flutter/models/response_ordered.dart';
import 'package:test_flutter/models/response_status_cancel.dart';
import 'package:test_flutter/models/response_status_ordered.dart';
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

  ResponseStatusOrdered _statusMessage =
      ResponseStatusOrdered(message: '', statusCode: 0, id: 0);

  ResponseStatusCancel _statusCancel =
      ResponseStatusCancel(message: '', statusCode: 0);

  bool get isLoading => _isLoading;
  bool get isInputVoucher => _isInputVoucher;
  bool get isOrdered => _isOrdered;
  String get kodeVoucher => _kodeVoucher;
  int? get voucherNominal => _voucherNominal;

  ResponseMenus get dataMenu => _menu;
  ResponseVoucher get dataVoucher => _voucher;
  ResponseStatusOrdered get statusMessage => _statusMessage;
  ResponseStatusCancel get statusCancel => _statusCancel;

  ShopViewModel() {
    getMenus();
  }

  _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  setIsInputVoucher(bool isInputVouhcer) {
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
    setIsInputVoucher(true);
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

  _setStatusMessage(ResponseStatusOrdered statusMessage) {
    _statusMessage = statusMessage;
    notifyListeners();
  }

  _setStatusCancel(ResponseStatusCancel statusCancel) {
    _statusCancel = statusCancel;
    notifyListeners();
  }

  void getMenus() async {
    _setIsLoading(true);

    ResponseMenus response = await ShopService.getMenus();

    _setDataMenu(response);

    _setIsLoading(false);
  }

  void getVoucher(String kode) async {
    // _setIsLoading(true);

    ResponseVoucher response = await ShopService.postVoucher(kode);
    _setDataVoucher(response);
    // _setIsLoading(false);
  }

  void postOrder(ResponseOrdered ordered) async {
    // await ShopService.postItemOrdered(ordered).then((value) {
    //   return _setStatusMessage(value);
    // });
    ResponseStatusOrdered response = await ShopService.postItemOrdered(ordered);
    _setStatusMessage(response);
  }

  void cancelOrder() async {
    // await ShopService.cancelOrder(statusMessage.id).then((value) {
    //   return _setStatusCancel(value);
    // });

    _setIsLoading(true);

    ResponseStatusCancel response =
        await ShopService.cancelOrder(statusMessage.id);
    _setStatusCancel(response);

    _setIsLoading(false);
  }
}
