import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> checkStatus();
  Future<Either<Failure, void>> refreshToken(); // New method
}
