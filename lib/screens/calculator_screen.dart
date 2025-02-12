// Flutter 애플리케이션의 진입점
import 'package:flutter/material.dart'; // Flutter의 UI 라이브러리
import 'package:math_expressions/math_expressions.dart'; // 수식 평가 라이브러리
import '../widgets/calculator_button.dart'; // 버튼 위젯을 포함하는 파일

// CalculatorScreen: 계산기 화면을 담당하는 StatefulWidget
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

// _CalculatorScreenState: 상태를 관리하는 클래스
class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = ""; // 사용자가 입력한 수식을 저장하는 변수
  String _output = "0"; // 계산 결과를 저장하는 변수

  // 버튼 클릭 시 호출되는 함수
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        // 'C' 버튼을 누르면 수식과 결과 초기화
        _expression = "";
        _output = "0";
      } else if (value == "⌫") {
        // '⌫' 버튼을 누르면 한 글자씩 삭제
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == "=") {
        // '=' 버튼을 누르면 수식을 평가하여 결과를 출력
        try {
          _output = _evaluateExpression(_expression);
        } catch (e) {
          _output = "Error";
        }
      } else {
        // 유효한 입력값이면 수식에 추가
        if (_isValidInput(value)) {
          _expression += value;
        }
      }
    });
  }

  // 입력값이 유효한지 확인하는 함수
  bool _isValidInput(String value) {
    // 연산자로 시작하는 경우 방지
    if (_expression.isEmpty &&
        (value == "+" || value == "-" || value == "*" || value == "/")) {
      return false;
    }
    // 연속된 '.' 입력 방지
    if (_expression.endsWith(".") && value == ".") {
      return false;
    }
    // 연산자가 연속해서 입력되지 않도록 방지
    if (_expression.isNotEmpty &&
        "+-*/".contains(_expression[_expression.length - 1]) &&
        "+-*/".contains(value)) {
      return false;
    }
    return true;
  }

  // 문자열 수식을 평가하여 결과를 반환하는 함수
  String _evaluateExpression(String exp) {
    try {
      Parser p = Parser(); // 수식 해석기 생성
      Expression expression = p.parse(exp); // 문자열을 수식으로 변환
      ContextModel cm = ContextModel(); // 변수 값 없이 평가할 컨텍스트 생성
      double result = expression.evaluate(EvaluationType.REAL, cm); // 수식을 평가
      return result.toString(); // 결과를 문자열로 변환하여 반환
    } catch (e) {
      return "Error"; // 예외 발생 시 'Error' 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 계산기")), // 앱 상단바 제목 설정
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
                    _expression, // 현재 입력된 수식 표시
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _output, // 계산 결과 표시
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Column(
            children: [
              Row(children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/")
              ]),
              Row(children: [
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("*")
              ]),
              Row(children: [
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-")
              ]),
              Row(children: [
                _buildButton("C"),
                _buildButton("0"),
                _buildButton("."),
                _buildButton("+")
              ]),
              Row(children: [_buildButton("⌫"), _buildButton("=")]),
            ],
          )
        ],
      ),
    );
  }

  // 버튼을 생성하는 함수
  Widget _buildButton(String text) {
    return CalculatorButton(
      text: text,
      onPressed: () => _onButtonPressed(text),
    );
  }
}
