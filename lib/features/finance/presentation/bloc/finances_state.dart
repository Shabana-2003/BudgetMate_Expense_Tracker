import 'package:budgetmate/features/finance/data/models/finances_data.dart';

import 'package:equatable/equatable.dart';

abstract class FinancesState extends Equatable {
  const FinancesState();

  @override
  List<Object> get props => [];
}

class FinancesInitial extends FinancesState {}

class FinancesLoading extends FinancesState {}

class FinancesLoaded extends FinancesState {
  final List<FinancesData> finances;

  const FinancesLoaded(this.finances);

  @override
  List<Object> get props => [finances];
}

class FinancesError extends FinancesState {
  final String message;

  const FinancesError(this.message);

  @override
  List<Object> get props => [message];
}
