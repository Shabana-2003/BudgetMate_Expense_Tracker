import 'package:budgetmate/features/auth/domain/entities/user.dart';
import 'package:budgetmate/features/auth/domain/repositories/auth_repository.dart';

class LoginUserWithEmailAndPassword {
  final AuthRepository repository;

  LoginUserWithEmailAndPassword(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.loginUserWithEmailAndPassword(email, password);
  }
}
