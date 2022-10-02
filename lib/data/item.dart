class Item {
  final String id;
  final String name;
  final String details;
  final String photo;
  final double price;
  int cartQuantity = 0;

  Item(
      {required this.id,
      required this.name,
      required this.details,
      required this.photo,
      required this.price});
}
