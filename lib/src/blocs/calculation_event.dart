import 'package:equatable/equatable.dart';

sealed class CalculationEvent extends Equatable {
  const CalculationEvent();

  @override
  List<Object> get props => [];
}

/// Event fired when a number is pressed on the calculator keyboard
final class NumberPressed extends CalculationEvent {
  final String number;

  const NumberPressed({required this.number});

  @override
  List<Object> get props => [number];
}

/// Event fired when an operator is pressed on the calculator keyboard
final class OperatorPressed extends CalculationEvent {
  final String operator;

  const OperatorPressed({required this.operator});

  @override
  List<Object> get props => [operator];
}

/// Event fired when the decimal point is pressed on the calculator keyboard
final class DecimalPointPressed extends CalculationEvent {
  @override
  List<Object> get props => [];
}

/// Event fired when equal is pressed on the calculator keyboard
final class CalculateResult extends CalculationEvent {
  @override
  List<Object> get props => [];
}

// Event fired when clear is pressed on the calculator keyboard
final class ClearCalculation extends CalculationEvent {
  @override
  List<Object> get props => [];
}
