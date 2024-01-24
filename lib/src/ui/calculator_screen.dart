import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/src/blocs/calculation_event.dart';
import 'package:flutter_calculator/src/blocs/calculation_state.dart';
import 'package:flutter_calculator/src/blocs/calculator_bloc.dart';
import 'package:flutter_calculator/src/constants/app_config.dart';
import 'package:flutter_calculator/src/models/calculation.dart';
import 'package:flutter_calculator/src/ui/calculator/button_widget.dart';
import 'package:flutter_calculator/src/ui/calculator/result_widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late double width;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculationBloc, CalculationState>(
      builder: (context, CalculationState state) {
        return Column(
          children: [
            ResultWidget(
              result: _getResultDisplayText(state.model),
            ),
            Row(
              children: [
                _getCalculatorButton(
                  text: 'Clear',
                  onTap: clear,
                  backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ],
            ),
            Row(
              children: [
                _getCalculatorButton(
                  text: '7',
                  onTap: () => numberPressed(7),
                ),
                _getCalculatorButton(
                  text: '8',
                  onTap: () => numberPressed(8),
                ),
                _getCalculatorButton(
                  text: '9',
                  onTap: () => numberPressed(9),
                ),
                _getCalculatorButton(
                  text: '/',
                  onTap: () => operatorPressed('/'),
                  backgroundColor: const Color.fromRGBO(254, 149, 5, 1),
                  textColor: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                _getCalculatorButton(
                  text: '4',
                  onTap: () => numberPressed(4),
                ),
                _getCalculatorButton(
                  text: '5',
                  onTap: () => numberPressed(5),
                ),
                _getCalculatorButton(
                  text: '6',
                  onTap: () => numberPressed(6),
                ),
                _getCalculatorButton(
                  text: 'x',
                  onTap: () => operatorPressed('*'),
                  backgroundColor: const Color.fromRGBO(254, 149, 5, 1),
                  textColor: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                _getCalculatorButton(
                  text: '1',
                  onTap: () => numberPressed(1),
                ),
                _getCalculatorButton(
                  text: '2',
                  onTap: () => numberPressed(2),
                ),
                _getCalculatorButton(
                  text: '3',
                  onTap: () => numberPressed(3),
                ),
                _getCalculatorButton(
                  text: '-',
                  onTap: () => operatorPressed('-'),
                  backgroundColor: const Color.fromRGBO(254, 149, 5, 1),
                  textColor: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                _getCalculatorButton(
                  text: '=',
                  onTap: calculateResult,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                ),
                _getCalculatorButton(text: '0', onTap: () => numberPressed(0)),
                _getCalculatorButton(
                  text: '.',
                  onTap: decimalPointPressed,
                  backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
                ),
                _getCalculatorButton(
                  text: '+',
                  onTap: () => operatorPressed('+'),
                  backgroundColor: const Color.fromRGBO(254, 149, 5, 1),
                  textColor: Colors.white,
                )
              ],
            ),
          ],
        );
      },
    );
  }

  /// Function that creates a button for calculator keyboard
  Widget _getCalculatorButton({
    required String text,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    double buttonWidth = width / AppConfig.keyboardColumnsNumber - 12;
    double buttonHeight = width / AppConfig.keyboardColumnsNumber - 12;

    if (text.toLowerCase() == 'clear') {
      buttonWidth = width - 12;
    }

    return ButtonWidget(
      label: text,
      onTap: onTap,
      width: buttonWidth,
      height: buttonHeight,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  /// Function invoked when a number is pressed on the calculator keyboard
  ///
  /// This function will add the `NumberPressed` event in the Bloc
  void numberPressed(int number) {
    context
        .read<CalculationBloc>()
        .add(NumberPressed(number: number.toString()));
  }

  /// Function invoked when an operator is pressed on the calculator keyboard
  ///
  /// This function will add the `OperatorPressed` event in the Bloc
  void operatorPressed(String operator) {
    context.read<CalculationBloc>().add(OperatorPressed(operator: operator));
  }

  /// Function invoked when the decimal point is pressed on the calculator keyboard
  ///
  /// This function will add the `DecimalPointPressed` event in the Bloc
  void decimalPointPressed() {
    context.read<CalculationBloc>().add(DecimalPointPressed());
  }

  /// Function invoked when the equal sign is pressed on the calculator keyboard
  ///
  /// This function will add the `CalculateResult` event in the Bloc
  void calculateResult() {
    context.read<CalculationBloc>().add(CalculateResult());
  }

  /// Function invoked when the clear button is pressed on the calculator keyboard
  ///
  /// This function will add the `ClearCalculation` event in the Bloc
  void clear() {
    context.read<CalculationBloc>().add(ClearCalculation());
  }

  /// Get the text that will be displayed in the calculator result section
  String _getResultDisplayText(Calculation model) {
    print(model.toString());

    if (model.result != null) {
      return '${model.result}';
    }

    if (model.secondNumber != null) {
      return '${model.firstNumber}${model.operator}${model.secondNumber}';
    }

    if (model.operator != null) {
      return '${model.firstNumber}${model.operator}';
    }

    if (model.firstNumber != null) {
      return '${model.firstNumber}';
    }

    return '${model.result ?? 0}';
  }
}
