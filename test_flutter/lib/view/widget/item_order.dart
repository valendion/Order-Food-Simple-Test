import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_flutter/view/style/theme.dart';

class ItemOrder extends StatelessWidget {
  final int id;
  final String nama;
  final String harga;
  final String gambar;

  const ItemOrder(
      {Key? key,
      required this.id,
      required this.nama,
      required this.harga,
      required this.gambar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                  child: Image.network(
                gambar,
                height: 75,
                width: 75,
              )),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: textTitleItemBlack),
                const SizedBox(
                  height: 8,
                ),
                Text('Rp $harga', style: textSubTitleItemBlue),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/add_note.svg',
                      height: 11,
                      width: 13,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text('Tambahkan Catatan')
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: (() {}),
                  child: SvgPicture.asset(
                    'assets/images/ic_add.svg',
                    height: 22,
                    width: 22,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  '0',
                  style: textTitleItemBlack,
                ),
                const SizedBox(
                  width: 12,
                ),
                SvgPicture.asset(
                  'assets/images/ic_min.svg',
                  height: 22,
                  width: 22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
