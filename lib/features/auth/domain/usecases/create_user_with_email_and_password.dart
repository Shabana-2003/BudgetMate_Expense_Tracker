import 'package:budgetmate/features/auth/domain/entities/user.dart';
import 'package:budgetmate/features/auth/domain/repositories/auth_repository.dart';

class CreateUserWithEmailAndPassword {
  final AuthRepository repository;

  CreateUserWithEmailAndPassword(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.createUserWithEmailAndPassword(email, password);
  }
}
