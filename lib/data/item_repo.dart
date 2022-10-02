import 'package:demo/data/item.dart';

List<Item> getItems() {
  final mList = <Item>[];

  for (var i = 0; i < 20; i++) {
    mList.add(Item(
        id: "$i",
        name: "Product $i",
        details:
            "Details of Product $i. orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        photo:
            "https://static-01.daraz.com.bd/p/a10a16f19d143fd12e40e1040b6fd6d0.jpg_200x200q80-product.jpg_.webp",
        price: (100.0 - i)));
  }

  return mList;
}
