import 'package:calculator/models/model_calculation_history_item.dart';
import 'package:calculator/screens/calculator_history.dart';
import 'package:calculator/util/theme.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';

class CalculatorHomeScreen extends StatefulWidget {
  const CalculatorHomeScreen({super.key});
  @override
  State<CalculatorHomeScreen> createState() => CalculatorHomeScreenState();
}

class CalculatorHomeScreenState extends State<CalculatorHomeScreen> {
  //operand 1
  String num1 = '';
  //operator
  String operand = '';
  //operand 2
  String num2 = '';
  //answer text
  String answertext = '';
  //List of buttons
  List buttonText = [
    'AC',
    'D',
    '^2',
    '%',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  //List to store history items
  List<CalculationHistoryItem> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //app bar
        appBar: AppBar(
          backgroundColor: background,
          leading: IconButton(
              icon: const Icon(
                Icons.history,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CalculatorHistoryScreen(history: history)))),
          title: const Text("Calculator",
              style: TextStyle(fontSize: 2, fontWeight: FontWeight.w700)),
          elevation: 0,
        ),
        backgroundColor: color3,
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "$num1$operand$num2".isEmpty
                                ? '0'
                                : "$num1$operand$num2",
                            style: const TextStyle(fontSize: 45))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(answertext,
                            style: const TextStyle(fontSize: 35))),
                  ),
                ],
              ))),
          Expanded(
            flex: 2,
            child: ClipRRect(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: background,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          onButtonTap(buttonText[index]);
                        },
                        child: CalculatorButton(
                          btntxt: buttonText[index],
                          btncolor: Colors.white,
                          btncolor2: btncolorselect(buttonText[index]),
                        ),
                      );
                    },
                    itemCount: buttonText.length,
                  )),
            ),
          )
        ]));
  }

  //!########## On Button Tapped Function ##########//
  onButtonTap(value) {
    // If user taps 'AC' => All clear
    if (value == 'AC') {
      clear(value);
    }
    // If user taps 'D' => Delete
    if (value == 'D') {
      delete(value);
    }

    // If user taps '^2' => Square - Power raise to 2
    if (value == '^2') {
      square(value);
    }

    // If user taps '%' => Percentage
    if (value == '%') {
      percentage(value);
    }

    // If user taps '='
    if (value == '=') {
      calculate();
    }

    //Adding values to num1, operand and num2
    if (value != 'AC' && value != 'D' && value != '=') {
      append(value);
    }
  }

  //!########## To add values to num1 and num2 ##########//
  void append(value) {
    //To  check if operand pressed and not '.'
    if (value != '.' && int.tryParse(value) == null) {
      if (CalculatorHomeScreenState().operand.isNotEmpty &&
          CalculatorHomeScreenState().num2.isNotEmpty) {
        //Calculation before assigning new operand value to var operand
        calculate();
      }
      operand = value;
    }
    //To add value to num1 and operand
    else if (num1.isEmpty || operand.isEmpty) {
      //num1='' || operand=''
      if (value == '.' && num1.contains('.'))
        return;
      //To display num 1 as 0. if empty
      else if (value == '.' && (num1.isEmpty || num1 == '0')) {
        //num1 = '' || num1 = '0'
        value = '0.';
      }
      num1 += value;
    }
    //To add value to num1 and operand
    else if (num2.isEmpty || operand.isNotEmpty) {
      //num1='some value like 456' || operand='some operator value'
      if (value == '.' && num2.contains('.'))
        return;
      //To display num2 as 0. if empty
      else if (value == '.' && (num2.isEmpty || num2 == '0')) {
        //num2 = '' || num2 = '0'
        value = '0.';
      }
      num2 += value;
    }
    setState(() {});
  }

  //!########## Delete Function ##########//
  void delete(value) {
    //To delete last digit of num2
    if (num2.isNotEmpty) {
      num2 = num2.substring(0, num2.length - 1);
    }
    //To delete operand
    else if (num2.isEmpty && operand.isNotEmpty) {
      operand = '';
    }

    //To delete last digit of num1
    else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }
    setState(() {});
  }

  // //!########## Percentage Function ##########//
  percentage(value) {
    //Ex: 123 + 456
    if (num1.isNotEmpty && operand.isNotEmpty && num2.isNotEmpty) {
      //Evaluate expression then calculate percentage
      calculate();
    }
    //Ex: 123+, 123+ %
    else if (num1.isNotEmpty && operand.isNotEmpty) {
      return;
    }
    double num = 0;
    num = double.parse(num1);
    num = num / 100;
    // num1 = num.toString();

    // Create a CalculationHistoryItem with the equation and result
    CalculationHistoryItem historyItem =
        CalculationHistoryItem(equation: " $num1%", result: num.toString());

    //Add historyitem to list
    history.add(historyItem);
    setState(() {
      answertext = num.toString();
    });
  }

  //!########## Square Function ##########//
  void square(value) {
    if (num1.isNotEmpty && operand.isNotEmpty && num2.isNotEmpty) {
      // '123' '+' '456'
      calculate();
    } else if (num1.isNotEmpty && operand.isNotEmpty) {
      return;
    } else if (num1.isEmpty) {
      return;
    }

    double num = 0;
    num = double.parse(num1);
    num = num * num;
    // Create a CalculationHistoryItem with the equation and result
    CalculationHistoryItem historyItem =
        CalculationHistoryItem(equation: " $num1^2", result: num.toString());

    //Add historyitem to list
    history.add(historyItem);

    setState(() {
      answertext = '$num';
      if (answertext.endsWith('.0')) {
        answertext = answertext.substring(0, answertext.length - 2);
      }
    });
  }

//!########## Calculate Function ##########//
  calculate() {
    //! num1 operand num2
    //  '' '' ''
    if (num1.isEmpty) return;

    //  '123' ''  ''
    if (operand.isEmpty) return;

    //  '123' 'operand' ''
    if (num2.isEmpty) return;

    //'123' 'operand' '456'
    double number1 = double.parse(num1);
    double number2 = double.parse(num2);
    double result = 0;

    switch (operand) {
      case '+':
        result = number1 + number2;
        break;
      case '-':
        result = number1 - number2;
        break;
      case 'x':
        result = number1 * number2;
        break;
      case '/':
        result = number1 / number2;
        break;
      default:
        return;
    }

    // Create a CalculationHistoryItem with the equation and result
    CalculationHistoryItem historyItem = CalculationHistoryItem(
        equation: "$num1 $operand $num2", result: result.toString());

    history.add(historyItem);

    setState(() {
      answertext = "$result";

      if (answertext.endsWith('.0')) {
        answertext = answertext.substring(0, answertext.length - 2);
      }

      operand = '';
      num1 = '$result';
      num2 = '';
    });
  }

  //!########## Clear Function ##########//
  clear(String value) {
    setState(() {
      num1 = '';
      num2 = '';
      operand = '';
      answertext = '';
    });
  }

  //! To return different button color for operands, values , = ...
  btncolorselect(String x) {
    if (x == 'AC' ||
        x == 'D' ||
        x == '^2' ||
        x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '%') {
      return color2;
    } else {
      return color3;
    }
  }
}
