import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/view/style/theme.dart';
import 'package:test_flutter/view/widget/input_voucher.dart';
import 'package:test_flutter/view/widget/nominal_voucher.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';
import '../../view_model/item_view_model.dart';

class FooterOrder extends StatelessWidget {
  const FooterOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemViewModel itemViewModel = context.watch<ItemViewModel>();
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();
    itemViewModel.setTotalPrice(shopViewModel.voucherNominal ?? 0);
    var jml = itemViewModel.itemCount;
    var total = itemViewModel.totalAmount;
    var totalPrice = itemViewModel.totalPrice;
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
                  onPressed: () {},
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: colorGreen),
                ),
              ],
            )),
      )
    ]);
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
