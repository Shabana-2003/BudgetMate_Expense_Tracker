import 'package:budgetmate/features/auth/domain/repositories/auth_repository.dart';

class SendPasswordResetLink {
  final AuthRepository repository;

  SendPasswordResetLink(this.repository);

  Future<void> call(String email) async {
    return await repository.sendPasswordResetLink(email);
  }
}
