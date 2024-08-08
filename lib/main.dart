import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
  ));
}
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

// variables 
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

// method
onButtonClick(value){
  //if value is AC
  if(value == "AC"){     // Reseting the values 
    input = '';
    output = '';
  }else if(value == "<"){
    if(input.isNotEmpty){
    input = input.substring(0 , input.length - 1);     // remove last value of input digit
    }
  }else if(value == "="){
    if(input.isNotEmpty){
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
    if(output.endsWith(".0")){
      output = output.substring(0 , output.length - 2);     // remove ZERO value of output digit
      }
      input = output; 
      hideInput = true;
      outputSize = 52;
    }
  }else {
    input = input + value;
    hideInput = false;
    outputSize = 34;
  }
  setState(() { });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          // input output area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Color.fromARGB(255, 255, 30, 30),
                    ),
                  ),
                  const SizedBox(
                    height: 20,     // give space
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 30,     // give space B/W buttons and I/O area
                  ),
                ],
              ),
            ),
          ),

          // buttons area
          Row(
            children: [
              button(text: "AC", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "<", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "", buttonBgColor: Colors.transparent),
              button(text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "6"),
              button(text: "5"),
              button(text: "-", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
        ],
      ),
    );

  }

  Widget button({
    text, tColor = Colors.white, buttonBgColor = buttonColor
  }){
    return Expanded(
      child: 
        Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonBgColor),
            onPressed: () => onButtonClick(text),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        )
    );
  }
}