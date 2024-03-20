import 'package:calculator/util/theme.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {

  final String btntxt;
  final  btncolor;
  final  containercolor;
  final btncolor1;
  final btncolor2;
  final buttonTapped;
   CalculatorButton({
    super.key,
     required this.btntxt,
     this.btncolor,
     this.buttonTapped,
     this.containercolor,
     this.btncolor1,
     this.btncolor2,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color1,
              btncolor2,
            ]
            ),
          //color: containercolor,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(
              color: btncolor,
              fontWeight:FontWeight.bold,
              fontSize: 25
              ),)),
      ),
    );
  }
}
