import 'package:flutter/material.dart';

import '../data/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item, required this.onClick})
      : super(key: key);

  final Function(Item) onClick;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(item.photo, height: 140, width: 140),
          Text(
            item.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            "Price: ${item.price.toInt()} Tk",
            style: const TextStyle(fontSize: 14),
          ),
          MaterialButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                onClick(item);
              },
              child: const Text("View")),
        ],
      ),
    );
  }
}
