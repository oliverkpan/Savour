
import 'package:flutter/widgets.dart';

class Item {
  @required
  String itemName;
  @required
  int itemPrice;
  @required
  String itemCode;
  @required
  int itemAvg;
  Item({
    this.itemName,
    this.itemPrice,
    this.itemCode,
    this.itemAvg,
  });
}
