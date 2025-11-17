import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;
  const RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.refreshToken();
  }
}
