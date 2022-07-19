import 'package:flutter/cupertino.dart';

class ItemViewModel extends ChangeNotifier {
  int _countItem = 0;

  int get countItem => _countItem;

  setCountItemIncrement() {
    _countItem++;
  }

  setCountItemDecrement() {
    _countItem--;
  }
}
