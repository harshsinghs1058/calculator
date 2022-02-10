import 'dart:math';
import "package:flutter/material.dart";

import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double num1 = 0;
  double num2 = 0;
  int input = 0;
  int temp = 0;
  String textToDisplay = "";
  String textO = "";
  String opr = "";
  Widget template(String i) {
    return Flexible(
      child: Container(
        height: 85.0,
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            if (i == "+" || i == "-" || i == "x" || i == "/" || i == "%") {
              if (input > 0 || textO != 0) {
                temp = 0;
                if (textToDisplay != "" && textO != "") {
                  num2 = double.parse(textToDisplay);
                  double ans;
                  if (i == "+") {
                    ans = num1 + num2;
                  } else if (i == "-") {
                    ans = num1 - num2;
                  } else if (i == "x") {
                    ans = num1 * num2;
                  } else if (i == "/") {
                    ans = num1 / num2;
                  } else if (i == "%") {
                    ans = (num1 * num2) / 100;
                  }
                  if (ans < 10000000000 && ans > -10000000000) {
                    if (ans != ans.toInt())
                      textO = (ans).toStringAsFixed(3);
                    else
                      textO = (ans).toInt().toString();
                  } else
                    textO = (ans).toStringAsExponential(3);
                  textO += i;
                  opr = i;
                  textToDisplay = "";
                } else if (textToDisplay != "") {
                  input = 0;
                  opr = i;
                  if (textToDisplay == "-") {
                    textToDisplay += "1";
                  }
                  num1 = double.parse(textToDisplay);

                  if (num1 < 10000000000 && num1 > -10000000000) {
                    if (num1 == num1.toInt())
                      textO = (num1).toInt().toString();
                    else
                      textO = num1.toStringAsFixed(3);
                  } else
                    textO = (num1).toStringAsExponential(3);
                  textO += opr;
                  textToDisplay = "";
                } else {
                  opr = i;
                  textO = textO.substring(0, textO.length - 1);
                  textO += opr;
                }
              }
            } else if (i == "√") {
              if (input > 0)
                textToDisplay =
                    sqrt(int.parse(textToDisplay)).toStringAsFixed(3);
            } else if (i == "=") {
              if (textO != "" && textToDisplay == "") {
              } else {
                temp = 10;
                textO = "";
                input = 0;
                if (textToDisplay == "-") {
                  textToDisplay += "1";
                }
                num2 = double.parse(textToDisplay);
                double ans;
                if (opr == "+") {
                  ans = (num1 + num2);
                } else if (opr == "-") {
                  ans = (num1 - num2);
                } else if (opr == "/") {
                  ans = (num1 / num2);
                } else if (opr == "x") {
                  ans = (num1 * num2);
                } else if (opr == "%") {
                  ans = (num2 * 100) / (num1);
                }
                if (ans < 10000000000 && ans > -10000000000) {
                  if (ans != ans.toInt())
                    textToDisplay = (ans).toStringAsFixed(3);
                  else
                    textToDisplay = (ans).toInt().toString();
                } else
                  textToDisplay = (ans).toStringAsExponential(3);
              }
            } else if (i == "C") {
              temp = 0;
              num1 = 0;
              input = 0;
              num2 = 0;
              textToDisplay = "";
              opr = "";
              textO = "";
            } else if (i == "D") {
              if (input > 0) {
                input--;
                textToDisplay =
                    textToDisplay.substring(0, textToDisplay.length - 1);
              }
            } else {
              if (input > 13) {
                Fluttertoast.showToast(
                    msg: "can,t add more than 13 numbers",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    // backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 20.0);
              } else if (temp == 0) {
                input++;
                textToDisplay += i;
              }
            }
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            padding: EdgeInsets.all(1.0),
            onPrimary: Colors.blue[300],
          ),
          child: Text(
            "$i",
            style: TextStyle(
              fontSize: 45.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Calculator"),
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    child: Text(
                      "$textO",
                      style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(bottom: 10, right: 15),
                  ),
                  Container(
                    child: Text(
                      "$textToDisplay",
                      style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(bottom: 10, right: 15),
                  ),
                ],
              ),
              Divider(
                color: Colors.yellow,
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  template("C"),
                  template("√"),
                  template("%"),
                  template("/"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  template("7"),
                  template("8"),
                  template("9"),
                  template("x"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  template("4"),
                  template("5"),
                  template("6"),
                  template("-"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  template("1"),
                  template("2"),
                  template("3"),
                  template("+"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  template("D"),
                  template("0"),
                  template("."),
                  template("="),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
