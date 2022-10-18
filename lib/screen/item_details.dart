import 'package:customizable_counter/customizable_counter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../data/item.dart';
import 'cart.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({Key? key, required this.mItem}) : super(key: key);

  final Item mItem;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseAnalytics.instance.logScreenView(screenName: "Item Details Screen");
    FirebaseAnalytics.instance.logViewItem(
      currency: "BDT",
      value: widget.mItem.price,
      items: [
        AnalyticsEventItem(
          itemId: widget.mItem.id,
          itemName: widget.mItem.name,
          price: widget.mItem.price,
          currency: "BDT",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.mItem.photo,
              height: 350,
              width: 400,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mItem.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Price: Tk ${widget.mItem.price.toInt()}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      widget.mItem.details,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomizableCounter(
                          backgroundColor: Colors.blueAccent,
                          buttonText: "Add To Cart",
                          textColor: Colors.white,
                          textSize: 18,
                          count: widget.mItem.cartQuantity.toDouble(),
                          step: 1,
                          minCount: 0,
                          maxCount: 10,
                          incrementIcon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decrementIcon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onIncrement: (count) {
                            FirebaseAnalytics.instance.logAddToCart(
                              currency: "BDT",
                              value: widget.mItem.price,
                              items: [
                                AnalyticsEventItem(
                                  itemId: widget.mItem.id,
                                  itemName: widget.mItem.name,
                                  price: widget.mItem.price,
                                  currency: "BDT",
                                  quantity: 1,
                                ),
                              ],
                            );
                          },
                          onDecrement: (count) {
                            FirebaseAnalytics.instance.logRemoveFromCart(
                              currency: "BDT",
                              value: widget.mItem.price,
                              items: [
                                AnalyticsEventItem(
                                  itemId: widget.mItem.id,
                                  itemName: widget.mItem.name,
                                  price: widget.mItem.price,
                                  currency: "BDT",
                                  quantity: 1,
                                ),
                              ],
                            );
                          },
                          onCountChange: (count) {
                            widget.mItem.cartQuantity = count.toInt();
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
