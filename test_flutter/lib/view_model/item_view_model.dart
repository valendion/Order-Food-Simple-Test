import 'package:flutter/cupertino.dart';
import 'package:test_flutter/models/item_counter.dart';

class ItemViewModel extends ChangeNotifier {
  // int _countItem = 0;
  // int _countPrice = 0;

  // List<ItemCounter> _items = [];

  // int get countItem => _countItem;
  // int get countPrice => _countPrice;

  // List<ItemCounter> get items => _items;

  // setItems(ItemCounter itemCounter) {
  //   _items.add(itemCounter);
  // }

  // // setCountItem(){
  // //   var filteredList
  // //   _items
  // // }

  // setCountItemIncrement(int price) {
  //   _countItem++;
  //   _countPrice += price;
  //   notifyListeners();
  // }

  // setCountItemDecrement(int price) {
  //   if (_countItem == 0) {
  //     _countItem = 0;
  //   } else {
  //     _countItem--;
  //   }

  //   if (_countPrice == 0) {
  //     _countPrice = 0;
  //   } else {
  //     _countPrice -= price;
  //   }
  //   notifyListeners();
  // }

  Map<int, ItemCounter> _cartItem = {};

  Map<int, ItemCounter> get cartItem {
    return {..._cartItem};
  }

  int get itemCount {
    return _cartItem.length;
  }

  void reduceItem(ItemCounter itemCounter) {
    if (itemCounter.quantity == 1) {
      _cartItem.remove(itemCounter.id);
      notifyListeners();
    } else if (itemCounter.quantity == 0) {
      return;
    } else {
      _cartItem.update(
        itemCounter.id,
        (itemCounter) => ItemCounter(
          id: itemCounter.id,
          name: itemCounter.name,
          price: itemCounter.price,
          quantity: itemCounter.quantity - 1,
        ),
      );
      notifyListeners();
    }
  }

  void addItem(ItemCounter itemCounter) {
    if (_cartItem.containsKey(itemCounter.id)) {
      //add quantity
      _cartItem.update(itemCounter.id, (existingCartItem) {
        return ItemCounter(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        );
      });
    } else {
      addToCart(itemCounter);
    }
    notifyListeners();
  }

  void addToCart(ItemCounter itemCounter) {
    _cartItem.putIfAbsent(
      itemCounter.id,
      () => ItemCounter(
        id: itemCounter.id,
        name: itemCounter.name,
        price: itemCounter.price,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  int get totalAmount {
    var total = 0;
    _cartItem.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void removeItem(int id) {
    _cartItem.remove(id);
    notifyListeners();
  }
}
