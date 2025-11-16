import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/either.dart';
import '../repositories/auth_repository.dart';

class CheckStatusUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  const CheckStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkStatus();
  }
}