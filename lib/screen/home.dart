import 'package:demo/app.dart';
import 'package:demo/components/item_card.dart';
import 'package:demo/screen/cart.dart';
import 'package:demo/screen/item_details.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mItemList =
        context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>()!.items;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "E-Commerce",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, height: 1.15),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Cart',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                })
          ],
        ),
        body: GridView.builder(
          itemCount: mItemList.length,
          padding: const EdgeInsets.all(25),
          itemBuilder: (context, index) => ItemCard(
              item: mItemList[index],
              onClick: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailsScreen(mItem: item),
                  ),
                );
              }),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: .7),
        ));
  }
}
