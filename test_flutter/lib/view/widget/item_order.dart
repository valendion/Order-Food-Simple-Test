import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/models/item_counter.dart';
import 'package:test_flutter/view/style/theme.dart';
import 'package:test_flutter/view_model/item_view_model.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';

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
    ItemViewModel itemViewModel = context.watch<ItemViewModel>();
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();

    if (!shopViewModel.isOrdered) {
      return _cardUi(itemViewModel, shopViewModel);
    } else {
      return (!itemViewModel.idOrdereds.contains(id))
          ? Opacity(opacity: 0.5, child: _cardUi(itemViewModel, shopViewModel))
          : _cardUi(itemViewModel, shopViewModel);
    }
  }

  _cardUi(ItemViewModel itemViewModel, ShopViewModel shopViewModel) {
    var textInputNote = TextEditingController();
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
                  height: 12,
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
                    SizedBox(
                      height: 14,
                      width: 150,
                      child: TextField(
                        // controller: textInputNote,
                        // onChanged: (value) {
                        //   itemViewModel.addNote(value, id);
                        // },

                        // onSubmitted: (value) {
                        //   itemViewModel.addNote(value, id);
                        // },
                        onChanged: (value) {
                          // textInputNote.text = itemViewModel.getNote(id) ?? '';
                          itemViewModel.addNote(value, id);
                        },
                        decoration: InputDecoration(
                            hintStyle: textSmallGrey,
                            hintText: 'Tambahkan Catatan'),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            _totalItemOrdered(shopViewModel.isOrdered, itemViewModel)
          ],
        ),
      ),
    );
  }

  _totalItemOrdered(bool isOrdered, ItemViewModel itemViewModel) {
    if (isOrdered) {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            VerticalDivider(
              color: colorGreyDark,
              thickness: 1,
            ),
            const SizedBox(
              width: 32,
            ),
            Text(
              '${(itemViewModel.cartItem[id]?.quantity ?? 0).toString()}',
              style: textTitleItemBlue,
            ),
            const SizedBox(
              width: 34,
            )
          ],
        ),
      );
    } else {
      return Row(
        children: [
          GestureDetector(
            onTap: (() {
              itemViewModel.addItem(ItemCounter(
                  id: id, name: nama, price: int.parse(harga), quantity: 0));
            }),
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
            (itemViewModel.cartItem[id]?.quantity ?? 0).toString(),
            style: textTitleItemBlack,
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              itemViewModel.reduceItem(ItemCounter(
                  id: id,
                  name: nama,
                  price: int.parse(harga),
                  quantity: itemViewModel.cartItem[id]?.quantity ?? 0));
            },
            child: SvgPicture.asset(
              'assets/images/ic_min.svg',
              height: 22,
              width: 22,
            ),
          ),
        ],
      );
    }
  }
}
