import 'package:flutter/material.dart';
import 'package:test_flutter/view/style/theme.dart';

class NominalVoucher extends StatelessWidget {
  int nominal;
  String kodeVoucher;

  NominalVoucher({required this.nominal, required this.kodeVoucher, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$kodeVoucher',
          style: textSmallGrey,
        ),
        Text(
          'Rp $nominal',
          style: textSmallRed,
        )
      ],
    );
  }
}
