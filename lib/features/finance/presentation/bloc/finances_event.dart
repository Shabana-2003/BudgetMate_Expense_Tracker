import 'package:equatable/equatable.dart';

abstract class FinancesEvent extends Equatable {
  const FinancesEvent();

  @override
  List<Object> get props => [];
}

class LoadFinances extends FinancesEvent {}
