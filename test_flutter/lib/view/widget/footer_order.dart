import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_flutter/view/style/theme.dart';

class FooterOrder extends StatelessWidget {
  const FooterOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jml = 3;
    var total = 28000;
    return Stack(children: [
      Container(
        height: 200,
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
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Voucher',
                  style: textSubtitleBoldBlack,
                ),
                Spacer(),
                Text(
                  'Input Voucher',
                  style: textSmallGrey,
                ),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  'assets/images/ic_next.svg',
                  height: 12,
                  width: 8,
                ),
              ],
            ),
            SizedBox(
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
                SizedBox(
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
                      'Rp $total',
                      style: textMediumBlue,
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Pesan Sekarang',
                    style: TextStyle(color: colorWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: colorGreen),
                )
              ],
            )),
      )
    ]);
  }
}
