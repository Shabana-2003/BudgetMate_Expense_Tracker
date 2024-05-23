import 'package:budgetmate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:budgetmate/features/auth/domain/entities/user.dart';
import 'package:budgetmate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> sendPasswordResetLink(String email) {
    return remoteDataSource.sendPasswordResetLink(email);
  }

  @override
  Future<User?> loginWithGoogle() async {
    final userCredential = await remoteDataSource.loginWithGoogle();
    return userCredential?.user != null
        ? User(uid: userCredential!.user!.uid, email: userCredential.user!.email)
        : null;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    final user = await remoteDataSource.createUserWithEmailAndPassword(email, password);
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  @override
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    final user = await remoteDataSource.loginUserWithEmailAndPassword(email, password);
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }
}
