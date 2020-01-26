import 'package:flutter/material.dart';
import '../objects/Item_object.dart';

class Groceries extends StatefulWidget {
  final Item groceries;
  final Function deleteTx;
  Groceries(
    this.groceries,
    this.deleteTx,
  );

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: Row(children: <Widget>[
          Text(""),
          Text(""),
        ]));
  }
}
