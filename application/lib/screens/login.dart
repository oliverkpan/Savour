import 'package:flutter/material.dart';
import 'package:savour_app/screens/budget_screen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Color.fromARGB(255, 96, 178, 249),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              Color.fromARGB(255, 55, 200, 155),
              Color.fromARGB(255, 96, 178, 249),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/noun_lemonINVERT.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage(
                      //     ,
                      //   ),
                      // ),
                    ),
                  ),
                  top: 6,
                  left: 6,
                ),
                Center(
                  child: Container(
                    height: 200,
                    width: 350,
                    child: Card(
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: TextField(
                              decoration: InputDecoration(
                                // border: InputBorder.none,
                                hintText: 'Email or Username',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                focusColor: Color.fromARGB(255, 96, 178, 249),
                                // border: InputBorder.none,
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BudgetScreen()));
                              },
                              color: Color.fromARGB(255, 40, 48, 76),
                              textColor: Colors.white,
                              child: Text("LOGIN NOW"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 177, 217, 252),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Create new account.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 177, 217, 252),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
