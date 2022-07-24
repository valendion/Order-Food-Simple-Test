import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/view/widget/app_loading.dart';
import 'package:test_flutter/view/widget/footer_order.dart';
import 'package:test_flutter/view/widget/item_order.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';
import '../../view_model/item_view_model.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();
    ItemViewModel itemViewModel = context.watch<ItemViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _ui(shopViewModel, itemViewModel),
            ),
            FooterOrder()
          ],
        ),
      ),
    );
  }

  _ui(ShopViewModel shopViewModel, ItemViewModel itemViewModel) {
    var dataMenus = shopViewModel.dataMenu.datas;
    if (shopViewModel.isLoading) {
      return const AppLoading();
    }
    return ListView.builder(
        itemCount: dataMenus.length,
        itemBuilder: (context, index) {
          return ItemOrder(
              id: dataMenus[index].id,
              nama: dataMenus[index].nama,
              harga: dataMenus[index].harga.toString(),
              gambar: dataMenus[index].gambar);
        });
  }
}
