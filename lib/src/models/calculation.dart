import 'package:equatable/equatable.dart';

class Calculation extends Equatable {
  const Calculation({
    this.firstNumber,
    this.operator,
    this.secondNumber,
    this.result,
  });

  final String? firstNumber;
  final String? operator;
  final String? secondNumber;
  final String? result;

  Calculation copyWith({
    String? firstNumber,
    String? operator,
    String? secondNumber,
    String? result,
  }) {
    return Calculation(
      firstNumber: firstNumber ?? this.firstNumber,
      operator: operator ?? this.operator,
      secondNumber: secondNumber ?? this.secondNumber,
      result: result,
    );
  }

  @override
  String toString() {
    return "$firstNumber $operator $secondNumber = $result";
  }

  @override
  List<Object?> get props => [firstNumber, operator, secondNumber, result];
}
