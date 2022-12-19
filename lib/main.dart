import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'colors.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secNum = 0.0;
  var input = " ";
  var output = " ";
  var operation = " ";
  var hideInput = false;
  var outputSize = 45;

  onButtonClick(value) {
    // if value is Ac
    if (value == "AC") {
      input = " ";
      output = " ";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputSize = 77;
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                color: Color.fromARGB(255, 17, 17, 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? " " : input,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: outputSize.toDouble(),
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // input Output Area;
                  ],
                ),
              ),
            ),
            // buttons Area
            Row(
              children: [
                button(
                  text: "AC",
                ),
                button(
                  text: "<",
                ),
                button(text: "", buttonBgColor: Colors.transparent),
                button(
                  text: "/",
                ),
              ],
            ),

            Row(
              children: [
                button(
                  text: "7",
                ),
                button(
                  text: "8",
                ),
                button(
                  text: "9",
                ),
                button(
                  text: "*",
                ),
              ],
            ),

            Row(
              children: [
                button(
                  text: "4",
                ),
                button(
                  text: "5",
                ),
                button(
                  text: "6",
                ),
                button(
                  text: "+",
                ),
              ],
            ),

            Row(
              children: [
                button(
                  text: "1",
                ),
                button(
                  text: "2",
                ),
                button(
                  text: "3",
                ),
                button(
                  text: "-",
                ),
              ],
            ),

            Row(
              children: [
                button(
                  text: "%",
                ),
                button(
                  text: "0",
                ),
                button(
                  text: ".",
                ),
                button(
                  text: "=",
                ),
              ],
            ),
          ],
        ));
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(22),
              primary: buttonBgColor),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
