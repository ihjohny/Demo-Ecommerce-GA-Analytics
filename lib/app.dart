import 'package:demo/data/item_repo.dart';
import 'package:flutter/cupertino.dart';

import 'data/item.dart';

class AppInheritedWidget extends InheritedWidget {
  AppInheritedWidget({super.key, required super.child});

  List<Item> items = getItems();

  @override
  bool updateShouldNotify(AppInheritedWidget oldWidget) {
    return items != oldWidget.items;
  }
}
