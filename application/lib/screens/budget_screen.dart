import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'dart:convert';
import '../DUMMY_DATA.dart';
import 'package:flutter/services.dart';

import 'package:barcode_scan/barcode_scan.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  String barcode;
  List<String> bars = [];
  bool entered = false;
  bool warning = false;

  Future barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(
        () {
          this.barcode = barcode;
          entered = true;
          if (barcode == "120") {
            warning = true;
          } else {
            warning = false;
          }
        },
      );

      bars.add(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
          entered = true;
        });
      } else {
        setState(() {
          this.barcode = 'Unknown error: $e';
          entered = true;

          if (barcode == "978123456789") {
            warning = true;
          } else {
            warning = false;
          }
        });
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  int totalPr = 0;
  double totalPe = 0;

  int totalPrice(dynamic myData) {
    for (int i = 0; i < myData.length; i++) {
      if (barcode == myData[i]["ID"]) {
        totalPr += myData[i]["Price"];
      }
    }
    return totalPr ~/ 2;
  }

  double totalPercent(dynamic myData) {
    int totalPr = totalPrice(myData);

    double totalPe = totalPr / 55;

    return totalPe;
  }

  @override
  initState() {
    super.initState();
  }

  List<String> code = [""];
  List<String> name = [""];
  List<int> price = [];
  List<int> avg = [];
  void parse() {
    if (DUMMY_GROCERIES.isNotEmpty) {
      for (int i = 1; i <= DUMMY_GROCERIES.length; i++) {
        DUMMY_GROCERIES.forEach((f) {
          name.add(f['itemName']);
          code.add(f['itemCode']);
          price.add(f['itemPrice']);
          avg.add(f["itemAvg"]);
        });
      }
      return null;
    }
  }

  // var myData = json.decode(snapshot.data.toString());
  @override
  Widget build(BuildContext context) {
    Widget _price = FutureBuilder(
      builder: (context, snapshot) {
        var myData = json.decode(snapshot.data.toString());
        return Text(
          "\$${totalPrice(myData).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 45,
            color: Colors.white,
          ),
        );
      },
      future: DefaultAssetBundle.of(context).loadString("assets/data.json"),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            stops: [0.05, 0.8],
            colors: [
              Colors.grey[300],
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.05, 0.8],
                  colors: [
                    Color.fromARGB(255, 55, 200, 155),
                    Color.fromARGB(255, 96, 178, 249),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width * 0.5, 30),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width * 0.5, 30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          var myData = json.decode(snapshot.data.toString());
                          return CircularPercentIndicator(
                            radius: 200.0,
                            lineWidth: 8.0,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: _price,
                            percent: totalPercent(myData),
                            progressColor: Colors.white,
                            backgroundColor: Color.fromARGB(0, 0, 0, 0),
                          );
                        },
                        future: DefaultAssetBundle.of(context)
                            .loadString("assets/data.json"),
                      ),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        return ((totalPr / 55) * 50) == 0
                            ? Text("")
                            : Text(
                                ((totalPr / 55) * 50).toStringAsFixed(0) + "%",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                      },
                      future: DefaultAssetBundle.of(context)
                          .loadString("assets/data.json"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                color: Color.fromARGB(255, 85, 184, 231),
                onPressed: barcodeScanning,
                child: Text(
                  "Scan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 300,
              width: 340,
              child: entered && bars.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: bars.length,
                      itemBuilder: (context, index) {
                        if (DUMMY_GROCERIES.isNotEmpty) {
                          parse();
                          for (int i = 0; i < code.length; i++) {
                            if (barcode == code[i]) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${name[i]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$${price[i - 1].toString()}.00',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 55, 200, 155),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                    )
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.arrow_upward,
                              size: 50.0,
                            ),
                          ),
                          Text(
                            "Scan your next item",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
        //     warning
        //         ? Container(
        //           height: 6,
        //             padding: EdgeInsets.only(left: 40, right: 40, bottom: 3),
        //             child: Text(
        //               "You are paying above the average of \$10.00 for Lobster!",
        //               style: TextStyle(
        //                   color: Colors.red,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 8),
        //             ),
        //           )
        //         : Container(
        //             height: 0,
        //           )
          ],
        ),
      ),
    );
  }
}
