import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _output = "0";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _output = "0";
      } else if (value == "⌫") {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == "=") {
        try {
          _output = _evaluateExpression(_expression);
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_isValidInput(value)) {
          _expression += value;
        }
      }
    });
  }

  bool _isValidInput(String value) {
    if (_expression.isEmpty && (value == "+" || value == "-" || value == "*" || value == "/")) {
      return false;
    }
    if (_expression.endsWith(".") && value == ".") {
      return false;
    }
    if (_expression.isNotEmpty &&
        "+-*/".contains(_expression[_expression.length - 1]) &&
        "+-*/".contains(value)) {
      return false;
    }
    return true;
  }

  String _evaluateExpression(String exp) {
    try {
      Parser p = Parser();
      Expression expression = p.parse(exp);
      ContextModel cm = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 계산기")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _output,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              Row(children: [_buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/")]),
              Row(children: [_buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*")]),
              Row(children: [_buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-")]),
              Row(children: [_buildButton("C"), _buildButton("0"), _buildButton("."), _buildButton("+")]),
              Row(children: [_buildButton("⌫"), _buildButton("=")]),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return CalculatorButton(
      text: text,
      onPressed: () => _onButtonPressed(text),
    );
  }
}
