import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '';
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = '';
        output = '';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (value == "=") {
        if (operator.isNotEmpty) {
          num2 = double.tryParse(input) ?? 0;
          switch (operator) {
            case '+':
              output = (num1 + num2).toString();
              break;
            case '-':
              output = (num1 - num2).toString();
              break;
            case '*':
              output = (num1 * num2).toString();
              break;
            case '/':
              output = (num2 != 0) ? (num1 / num2).toString() : "Error";
              break;
          }
          input = output;
          operator = '';
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (input.isNotEmpty) {
          num1 = double.tryParse(input) ?? 0;
          operator = value;
          input = '';
        }
      } else {
        if (value == '.' && input.contains('.')) return;
        input += value;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: InkWell(
        onTap: () => onButtonPressed(text),
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                input.isEmpty ? "0" : input,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                output,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ),
          for (var row in [
            ["7", "8", "9", "/"],
            ["4", "5", "6", "*"],
            ["1", "2", "3", "-"],
            ["C", "0", ".", "+"],
            ["="]
          ])
            Row(
              children: row.map((button) {
                return buildButton(button, color: button == "=" ? Colors.orange : Colors.grey[800]!);
              }).toList(),
            )
        ],
      ),
    );
  }
}
