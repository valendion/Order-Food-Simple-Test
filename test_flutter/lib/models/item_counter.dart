class ItemCounter {
  int id;
  String name;
  int price;
  int quantity;
  String? note;

  ItemCounter(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      this.note});
}
