import 'package:demo/data/item_repo.dart';
import 'package:demo/screen/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logScreenView(screenName: "Cart Screen");
  }

  @override
  Widget build(BuildContext context) {
    final mItemList = context
        .dependOnInheritedWidgetOfExactType<AppInheritedWidget>()!
        .items
        .where((element) => element.cartQuantity > 0)
        .toList();

    double totalCartValue = 0.0;
    for (var element in mItemList) {
      totalCartValue += (element.cartQuantity * element.price);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, height: 1.15),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: (mItemList.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: SizedBox(
                        height: 220,
                        child: ListView.builder(
                          itemCount: mItemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Text(
                                    "${mItemList[index].cartQuantity.toString()} X",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                trailing: Text(
                                  "Tk ${(mItemList[index].cartQuantity * mItemList[index].price).toInt()}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                title: Text(mItemList[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Tk ${totalCartValue.toInt()}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                            padding: const EdgeInsets.all(12),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      title: const Text('Congratulations'),
                                      content:
                                          const Text('Order Place Successful'),
                                      actions: [
                                        MaterialButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            context
                                                .dependOnInheritedWidgetOfExactType<
                                                    AppInheritedWidget>()!
                                                .items = getItems();
                                            Navigator.pop(context);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Place Order",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: Text(
                    "Empty Cart",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                )),
    );
  }
}
