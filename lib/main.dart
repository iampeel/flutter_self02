// Flutter 애플리케이션의 진입점
import 'package:flutter/material.dart'; // Flutter의 UI 라이브러리
import 'screens/calculator_screen.dart'; // 계산기 화면CalculatorScreen()을 포함하는 파일

// main() 함수: 앱이 실행될 때 처음 호출되는 함수
void main() {
  runApp(CalculatorApp()); // CalculatorApp 위젯을 실행
}

// CalculatorApp: 앱의 루트 위젯 (StatelessWidget 사용)
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: CalculatorScreen(), // 앱이 실행될 때 첫 번째 화면으로 CalculatorScreen 표시
    );
  }
}
