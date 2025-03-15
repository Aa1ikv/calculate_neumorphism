import 'package:flutter/material.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  var screenValue = "0";
  String? operator;
  double? firstNumber;
  double? secondNumber;


  void _onNumberPressed(String number) {
    setState(() {
      if (screenValue == "0") {
        screenValue = number;
      } else {
        screenValue += number;
      }
    });
  }


  void _onOperatorPressed(String newOperator) {
    setState(() {
      if (operator != null) {
        _calculate();
      }
      firstNumber = double.parse(screenValue);
      operator = newOperator;
      screenValue = "0";
    });
  }


  void _onEqualsPressed() {
    setState(() {
      _calculate();
      operator = null;
    });
  }

  void _onClearPressed() {
    setState(() {
      screenValue = "0";
      operator = null;
      firstNumber = null;
      secondNumber = null;
    });
  }
  void _onToggleSign() {
    setState(() {
      if (screenValue != "0") {
        if (screenValue.startsWith('-')) {
          screenValue = screenValue.substring(1);
        } else {
          screenValue = '-$screenValue';
        }
      }
    });
  }


  void _onPercentagePressed() {
    setState(() {
      double value = double.parse(screenValue);
      screenValue = (value / 100).toString();
    });
  }


  void _onDecimalPressed() {
    setState(() {
      if (!screenValue.contains('.')) {
        screenValue += '.';
      }
    });
  }


  void _calculate() {
    secondNumber = double.parse(screenValue);
    switch (operator) {
      case '+':
        screenValue = (firstNumber! + secondNumber!).toString();
        break;
      case '-':
        screenValue = (firstNumber! - secondNumber!).toString();
        break;
      case 'x':
        screenValue = (firstNumber! * secondNumber!).toString();
        break;
      case '/':
        screenValue = (firstNumber! / secondNumber!).toString();
        break;
    }
    firstNumber = double.parse(screenValue);
    secondNumber = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 270),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.transparent,
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 1,
                        right: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(35),
                          child: Text(
                            screenValue,
                            style: TextStyle(fontSize: 48, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                buildButton('C', color: Colors.white54, onTap: _onClearPressed),
                const SizedBox(width: 10),
                buildButton('+/-', color: Colors.white54, onTap: _onToggleSign),
                const SizedBox(width: 10),
                buildButton('%', color: Colors.white54, onTap: _onPercentagePressed),
                const SizedBox(width: 10),
                buildButton('/', color: Colors.orange, onTap: () => _onOperatorPressed('/')),
              ],
            ), // 1 ряд кнопок
            const SizedBox(height: 10),
            Row(
              children: [
                buildButton('7', color: Colors.white24, onTap: () => _onNumberPressed('7')),
                const SizedBox(width: 10),
                buildButton('8', color: Colors.white24, onTap: () => _onNumberPressed('8')),
                const SizedBox(width: 10),
                buildButton('9', color: Colors.white24, onTap: () => _onNumberPressed('9')),
                const SizedBox(width: 10),
                buildButton('x', color: Colors.orange, onTap: () => _onOperatorPressed('x')),
              ],
            ), // 2 ряд кнопок
            const SizedBox(height: 10),
            Row(
              children: [
                buildButton('4', color: Colors.white24, onTap: () => _onNumberPressed('4')),
                const SizedBox(width: 10),
                buildButton('5', color: Colors.white24, onTap: () => _onNumberPressed('5')),
                const SizedBox(width: 10),
                buildButton('6', color: Colors.white24, onTap: () => _onNumberPressed('6')),
                const SizedBox(width: 10),
                buildButton('-', color: Colors.orange, onTap: () => _onOperatorPressed('-')),
              ],
            ), // 3 ряд кнопок
            const SizedBox(height: 10),
            Row(
              children: [
                buildButton('1', color: Colors.white24, onTap: () => _onNumberPressed('1')),
                const SizedBox(width: 10),
                buildButton('2', color: Colors.white24, onTap: () => _onNumberPressed('2')),
                const SizedBox(width: 10),
                buildButton('3', color: Colors.white24, onTap: () => _onNumberPressed('3')),
                const SizedBox(width: 10),
                buildButton('+', color: Colors.orange, onTap: () => _onOperatorPressed('+')),
              ],
            ), // 4 ряд кнопок
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () => _onNumberPressed('0'),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white24,
                    ),
                    width: 164,
                    height: 77,
                    child: Center(
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                buildButton('.', color: Colors.white24, onTap: _onDecimalPressed),
                const SizedBox(width: 10),
                buildButton('=', color: Colors.orange, onTap: _onEqualsPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, {Color? color, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 77,
        height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}