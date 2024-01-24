import 'package:equatable/equatable.dart';
import 'package:flutter_calculator/src/models/calculation.dart';

sealed class CalculationState extends Equatable {
  final Calculation model;

  const CalculationState({required this.model});

  @override
  List<Object> get props => [model];
}

/// Initial calculation state (no calculation data is available)
final class CalculationInitial extends CalculationState {
  const CalculationInitial() : super(model: const Calculation());
}

/// State when something is changed in the calculation
class CalculationChanged extends CalculationState {
  final Calculation model;

  const CalculationChanged({required this.model}) : super(model: model);

  @override
  List<Object> get props => [model];
}
