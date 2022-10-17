import 'package:demo/app.dart';
import 'package:demo/components/item_card.dart';
import 'package:demo/screen/cart.dart';
import 'package:demo/screen/item_details.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logScreenView(screenName: "Home Screen");
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mItemList =
        context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>()!.items;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.location_on_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Expanded(
                    child: AlertDialog(
                      title: const Text('Location'),
                      content: TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Address',
                        ),
                      ),
                      actions: [
                        MaterialButton(
                          textColor: Colors.blueAccent,
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
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
