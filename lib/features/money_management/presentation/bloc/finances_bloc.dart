import 'package:bloc/bloc.dart';
import 'package:budgetmate/features/money_management/data/models/finances_data.dart';
import 'package:hive/hive.dart';

import 'finances_event.dart';
import 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  FinancesBloc() : super(FinancesInitial()) {
    on<LoadFinances>((event, emit) async {
      emit(FinancesLoading());
      try {
        final box = Hive.box<FinancesData>('data');
        final finances = box.values.toList();
        emit(FinancesLoaded(finances));
      } catch (e) {
        emit(const FinancesError('Failed to load finances'));
      }
    });
  }
}
