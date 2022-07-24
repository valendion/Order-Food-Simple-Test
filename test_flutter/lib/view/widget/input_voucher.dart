import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/view/style/theme.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';

import '../../view_model/item_view_model.dart';

class InputVoucher extends StatefulWidget {
  InputVoucher({Key? key}) : super(key: key);

  @override
  State<InputVoucher> createState() => _InputVoucherState();
}

class _InputVoucherState extends State<InputVoucher> {
  var inputVoucherField = TextEditingController();

  void clearText() {
    inputVoucherField.clear();
  }

  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          SvgPicture.asset(
            'assets/images/ic_voucher.svg',
            height: 22,
            width: 22,
          ),
          Text(
            'Punya kode voucher ?',
            style: textTitleItemBlack,
          )
        ]),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Masukkan kode voucher disini',
          style: textSubtitleBlack,
        ),
        const SizedBox(height: 18),
        TextField(
          controller: inputVoucherField,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: clearText, icon: const Icon(Icons.clear))),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              shopViewModel.getVoucher(inputVoucherField.text);
              Navigator.pop(context);
            },
            child: Text(
              'Validasi Voucher',
              style: TextStyle(color: colorWhite),
            ),
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), primary: colorGreen),
          ),
        ),
      ],
    );
  }
}
