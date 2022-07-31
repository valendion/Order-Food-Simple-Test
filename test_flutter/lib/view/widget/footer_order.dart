import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/models/response_ordered.dart';
import 'package:test_flutter/view/style/theme.dart';
import 'package:test_flutter/view/widget/input_voucher.dart';
import 'package:test_flutter/view/widget/nominal_voucher.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';
import '../../view_model/item_view_model.dart';

class FooterOrder extends StatelessWidget {
  const FooterOrder({Key? key}) : super(key: key);

  _showMessage(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: colorWhite,
          textColor: colorBlue,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemViewModel itemViewModel = context.watch<ItemViewModel>();
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();
    itemViewModel.setTotalPrice(shopViewModel.voucherNominal ?? 0);
    var jml = itemViewModel.itemCount;
    var total = itemViewModel.totalAmount;
    var totalPrice = itemViewModel.totalPrice;
    // _showMessage(shopViewModel.statusMessage.message);
    // _showMessage(shopViewModel.statusCancel.message);
    return Stack(children: [
      Container(
        height: 220,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        decoration: BoxDecoration(
            color: colorGrey,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Text(
                    'Total Pesanan',
                    style: textSubtitleBoldBlack,
                  ),
                  Text(
                    ' ($jml Menu) :',
                    style: textSubtitleBlack,
                  ),
                ],
              ),
              Text(
                'Rp $total',
                style: textRegularBlue,
              )
            ]),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: colorGreyDark,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_voucher.svg',
                  height: 22,
                  width: 22,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'Voucher',
                  style: textSubtitleBoldBlack,
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      _voucherClick(context);
                    },
                    child: _isInputVoucher(shopViewModel)),
                const SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  'assets/images/ic_next.svg',
                  height: 12,
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32))),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_basket.svg',
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: textSmallGrey,
                    ),
                    Text(
                      'Rp $totalPrice',
                      style: textMediumBlue,
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    var isOrdered = shopViewModel.isOrdered;
                    if (isOrdered) {
                      _uiAlerDialog(context, shopViewModel, itemViewModel);
                    } else {
                      shopViewModel.setOrdered(true);

                      List<Items> items = [];
                      itemViewModel.cartItem.forEach((key, value) {
                        items.add(Items(
                            id: value.id,
                            harga: value.price,
                            catatan: value.note ?? ''));
                      });

                      var responseOrder = ResponseOrdered(
                          nominalDiskon:
                              shopViewModel.voucherNominal.toString(),
                          nominalPesanan: totalPrice.toString(),
                          items: items);

                      shopViewModel.postOrder(responseOrder);

                      await Future.delayed(Duration(milliseconds: 1000));

                      _showMessage(shopViewModel.statusMessage.message);
                    }
                  },
                  child: Text(
                    _buttonOrdered(shopViewModel.isOrdered),
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(170, 42),
                      shape: const StadiumBorder(),
                      primary: colorGreen),
                ),
              ],
            )),
      )
    ]);
  }

  String _buttonOrdered(bool isButtonOrdered) {
    return (isButtonOrdered) ? 'Batalkan' : 'Pesan Sekarang';
  }

  _uiAlerDialog(BuildContext context, ShopViewModel shopViewModel,
      ItemViewModel itemViewModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Apakah Anda yakin ingin membatalkan pesanan ini ?'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    shopViewModel.setOrdered(false);
                    shopViewModel.cancelOrder();

                    itemViewModel.deleteItemCard();
                    shopViewModel.setIsInputVoucher(false);
                    await Future.delayed(Duration(milliseconds: 500));
                    _showMessage(shopViewModel.statusCancel.message);
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Yakin',
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 42),
                      shape: const StadiumBorder(),
                      primary: colorGreen)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Batal',
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 42),
                      shape: const StadiumBorder(),
                      primary: colorGreen)),
            ],
          );
        });
  }

  void _voucherClick(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: colorOpacityMin,
              height: 250,
              child: Container(
                padding: EdgeInsets.all(28),
                child: InputVoucher(),
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ),
          );
        });
  }

  _isInputVoucher(ShopViewModel shopViewModel) {
    if (shopViewModel.isInputVoucher) {
      return NominalVoucher(
          nominal: shopViewModel.voucherNominal ?? 0,
          kodeVoucher: shopViewModel.kodeVoucher);
    } else {
      return Text(
        'Input Voucher',
        style: textSmallGrey,
      );
    }
  }
}
