import 'package:budgetmate/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> sendPasswordResetLink(String email);
  Future<User?> loginWithGoogle();
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<User?> loginUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
