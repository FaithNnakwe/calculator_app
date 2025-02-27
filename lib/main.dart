import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp()); // Runs the CalculatorApp widget.
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(), // sets background color of the calculator to black.
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';  // Variable to collect user input
  String output = ''; // Variable to collect output
  double num1 = 0; // First operand
  double num2 = 0; // Second operand
  String operator = ''; // operator to store the current operation.

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") { // Resets all the data when 'C' is pressed
        input = '';
        output = '';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (value == "=") { // Calculates the result when '=' is pressed.
        if (operator.isNotEmpty) {
          num2 = double.tryParse(input) ?? 0; // Converts the input to a number
          switch (operator) {
            case '+': // case 1 performs addition
              output = (num1 + num2).toString();
              break;
            case '-': // case 2 performs subtraction
              output = (num1 - num2).toString();
              break;
            case '*': // case 3 performs multiplication
              output = (num1 * num2).toString();
              break;
            case '/': // case 4 performs Division.
              output = (num2 != 0) ? (num1 / num2).toStringAsFixed(5) : "Error"; // checks if the divisor is 0, which gives an error message and ensures that the output is fixed to 5 decimal places.
              break;
          }
          input = output; // Update input to display the result and assign output to input for continuous calculation.
          operator = ''; // Reset the operator after calculation
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (input.isNotEmpty) {
          num1 = double.tryParse(input) ?? 0;  // Convert input to number
          operator = value; // Set the operator
          input = '';
        }
      } else {
        if (value == '.' && input.contains('.')) return; // This condition prevents multiple decimal points.
        input += value;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: InkWell( // Wraps the button in InkWell to detect user taps.
        onTap: () => onButtonPressed(text), // When the button is pressed, call onButtonPressed
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
      backgroundColor: Colors.black, // sets background color of the screen
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                input.isEmpty ? "0" : input, // Show 0 if input is empty
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Expanded(  // Display the output of the calculation to with green font color
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                output,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ),
          for (var row in [ // uses the row to display row of buttons for the calculator
            ["7", "8", "9", "/"],
            ["4", "5", "6", "*"],
            ["1", "2", "3", "-"],
            ["C", "0", ".", "+"],
            ["="]
          ])
            Row(
              children: row.map((button) {
                return buildButton(button, color: button == "=" ? const Color.fromARGB(255, 9, 129, 227) : const Color.fromARGB(255, 198, 22, 201)!);
              }).toList(),
            )
        ],
      ),
    );
  }
}
