import 'package:budgetmate/features/money_management/data/models/finances_data.dart';
import 'package:hive/hive.dart';

abstract class FinancesDataSource {
  Future<void> addFinanceData(FinancesData data);
  List<FinancesData> getAllFinances();
}

class FinancesDataSourceImpl implements FinancesDataSource {
  final Box<FinancesData> financesBox;

  FinancesDataSourceImpl(this.financesBox);

  @override
  Future<void> addFinanceData(FinancesData data) async {
    await financesBox.add(data);
  }

  @override
  List<FinancesData> getAllFinances() {
    return financesBox.values.toList();
  }
}
