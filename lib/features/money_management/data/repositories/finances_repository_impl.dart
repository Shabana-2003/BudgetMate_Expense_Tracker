// import 'package:dartz/dartz.dart';
// import '../../domain/entities/finances_data.dart';
// import '../../domain/repositories/finances_repository.dart';
// import '../datasources/finances_data_source.dart';
// import '../models/finances_data_model.dart';
// import '../../../../core/error/failures.dart';

// class FinancesRepositoryImpl implements FinancesRepository {
//   final FinancesDataSource dataSource;

//   FinancesRepositoryImpl({required this.dataSource});

//   @override
//   Future<Either<Failure, void>> addFinanceData(FinancesData financesData) async {
//     try {
//       final model = FinancesDataModel(
//         name: financesData.name,
//         purpose: financesData.purpose,
//         amount: financesData.amount,
//         transactionType: financesData.transactionType,
//         dateTime: financesData.dateTime,
//         isFavorite: financesData.isFavorite,
//       );
//       await dataSource.addFinanceData(model);
//       return Right(null);
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }

//   @override
//   Either<Failure, List<FinancesData>> getAllFinances() {
//     try {
//       final models = dataSource.getAllFinances();
//       final finances = models.map((model) => FinancesData(
//         name: model.name,
//         purpose: model.purpose,
//         amount: model.amount,
//         transactionType: model.transactionType,
//         dateTime: model.dateTime,
//         isFavorite: model.isFavorite,
//       )).toList();
//       return Right(finances);
//     } catch (e) {
//       return Left(ServerFailure());
//     }
//   }
// }
