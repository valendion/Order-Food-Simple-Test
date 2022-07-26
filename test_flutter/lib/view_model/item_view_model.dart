import 'package:flutter/cupertino.dart';
import 'package:test_flutter/models/item_counter.dart';
import 'package:test_flutter/view_model/shop_view_model.dart';

class ItemViewModel extends ChangeNotifier {
  final Map<int, ItemCounter> _cartItem = {};

  Map<int, ItemCounter> get cartItem {
    return {..._cartItem};
  }

  final Set<int> _idOrdereds = {};

  int get itemCount {
    return _cartItem.length;
  }

  Set<int> get idOrdereds => _idOrdereds;

  int _totalPrice = 0;

  int get totalPrice => (_totalPrice <= 0) ? 0 : _totalPrice;

  setTotalPrice(int nominal) {
    _totalPrice = totalAmount - nominal;
  }

  setIdOrdered() {
    cartItem.forEach((key, value) {
      _idOrdereds.add(value.id);
    });
    notifyListeners();
  }

  setIdDeleteOrdered(int id) {
    _idOrdereds.removeWhere((element) => element == id);
    notifyListeners();
  }

  void reduceItem(ItemCounter itemCounter) {
    if (itemCounter.quantity == 1) {
      _cartItem.remove(itemCounter.id);
      setIdDeleteOrdered(itemCounter.id);
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
      setIdOrdered();
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
    setIdOrdered();
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
