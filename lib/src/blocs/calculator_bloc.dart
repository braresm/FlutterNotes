import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/src/blocs/calculation_event.dart';
import 'package:flutter_calculator/src/blocs/calculation_state.dart';
import 'package:flutter_calculator/src/constants/app_config.dart';
import 'package:flutter_calculator/src/models/calculation.dart';
import 'package:flutter_calculator/src/utils/calculator_utils.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc() : super(const CalculationInitial()) {
    /// Handle event when a number is pressed on the calculator keyboard
    on<NumberPressed>((event, emit) {
      final Calculation model = state.model;

      if (model.firstNumber == null) {
        // First number was not typed,
        // Create the model an emit the state
        final Calculation newModel = model.copyWith(firstNumber: event.number);
        return emit(CalculationChanged(model: newModel));
      }

      if (model.firstNumber!.endsWith('.') && model.operator == null) {
        // First number ends with a dot and an operator was not typed
        // then add the current digit to first number and emit the state
        final Calculation newModel = model.copyWith(
          firstNumber: '${model.firstNumber}${event.number}',
        );
        return emit(CalculationChanged(model: newModel));
      }

      if (model.operator == null) {
        // If the operator was not typed yet,
        // then add the current digit to the first number and emit the state
        final Calculation newModel = model.copyWith(
          firstNumber: '${model.firstNumber}${event.number}',
        );
        return emit(CalculationChanged(model: newModel));
      }

      if (model.secondNumber == null) {
        // Second number was not typed,
        // Create the model an emit the state
        final Calculation newModel = model.copyWith(secondNumber: event.number);
        return emit(CalculationChanged(model: newModel));
      }

      if (model.secondNumber!.endsWith('.') && model.operator != null) {
        // Second number ends with a dot and an operator was not typed
        // then add the current digit to second number and emit the state
        final Calculation newModel = model.copyWith(
          secondNumber: '${model.secondNumber}${event.number}',
        );
        return emit(CalculationChanged(model: newModel));
      }

      // Add the current digit to the second number and emit the state
      final Calculation newModel = model.copyWith(
        secondNumber: '${model.secondNumber}${event.number}',
      );
      return emit(CalculationChanged(model: newModel));
    });

    /// Handle event when an operator is pressed on the calculator keyboard
    on<OperatorPressed>((event, emit) {
      // If the operator is not an allowed value,
      // then emit the existing state
      if (!AppConfig.allowedOperators.contains(event.operator)) {
        return emit(state);
      }

      final Calculation model = state.model;

      if (model.firstNumber != null && model.secondNumber != null) {
        // Perform the calculation only if both numbers are typed
        dynamic calculationResult = _calculate(model);

        // Create the model an emit the state
        final Calculation newModel = const CalculationInitial().model.copyWith(
              firstNumber: calculationResult.toString(),
              operator: event.operator,
              result: calculationResult.toString(),
            );
        return emit(CalculationChanged(model: newModel));
      }

      // Create the model an emit the state
      final Calculation newModel = state.model.copyWith(
        firstNumber: model.firstNumber ?? '0',
        operator: event.operator,
        secondNumber: null,
        result: null,
      );
      return emit(CalculationChanged(model: newModel));
    });

    /// Handle event when decimal point is pressed on the calculator keyboard
    on<DecimalPointPressed>((event, emit) {
      final Calculation model = state.model;

      if (model.secondNumber != null && !model.secondNumber!.contains('.')) {
        // decimal point was pressed for the second number
        final Calculation newModel = model.copyWith(
          secondNumber: '${model.secondNumber}.',
        );
        return emit(CalculationChanged(model: newModel));
      }

      if (model.firstNumber != null && !model.firstNumber!.contains('.')) {
        // decimal point was pressed for the first number
        final Calculation newModel = model.copyWith(
          firstNumber: '${model.firstNumber}.',
        );
        return emit(CalculationChanged(model: newModel));
      }
    });

    /// Handle event when equal is pressed on the calculator keyboard
    on<CalculateResult>((event, emit) {
      final Calculation model = state.model;

      // If operator or second number not set,
      // then emit the current state and do nothing
      if (model.operator == null || model.secondNumber == null) {
        return emit(state);
      }

      // Perform the calculation
      dynamic calculationResult = _calculate(model);

      // Create the model an emit the state
      final Calculation newModel = const CalculationInitial().model.copyWith(
            firstNumber: calculationResult.toString(),
            result: calculationResult.toString(),
          );

      return emit(CalculationChanged(model: newModel));
    });

    /// Handle event when clear is pressed on the calculator keyboard
    on<ClearCalculation>((event, emit) {
      emit(
        CalculationChanged(model: const CalculationInitial().model.copyWith()),
      );
    });
  }

  /// Perform the calculation
  _calculate(Calculation model) {
    // Convert the operators from string to real numbers
    dynamic firstNumberValue =
        CalculatorUtils.convertStringToNumber(model.firstNumber);
    dynamic secondNumberValue =
        CalculatorUtils.convertStringToNumber(model.secondNumber);

    // Depending on the operator, perform the calculation and return the result
    switch (model.operator) {
      case '+':
        return firstNumberValue! + secondNumberValue!;
      case '-':
        return firstNumberValue! - secondNumberValue!;
      case '*':
        return firstNumberValue! * secondNumberValue!;
      case '/':
        if (secondNumberValue == 0) {
          return 0;
        } else {
          return firstNumberValue! / secondNumberValue!;
        }
    }
    return 0;
  }

  @override
  void onChange(Change<CalculationState> change) {
    super.onChange(change);
  }
}
