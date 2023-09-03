import "dart:math";

import "package:flutter/material.dart";

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amberAccent,
      child: Center(
          child: Text(
            luckyNo(),
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.blue, fontSize: 40),
          )),
    );
  }

  String luckyNo(){
    var random= Random();
    int number=random.nextInt(100);

    return "Your Lucky number is $number";
  }
}