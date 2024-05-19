import 'package:budgetmate/features/money_management/data/models/finances_data.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class FinancesRepository {
  Future<Either<Failure, void>> addFinanceData(FinancesData financesData);
  Either<Failure, List<FinancesData>> getAllFinances();
}
