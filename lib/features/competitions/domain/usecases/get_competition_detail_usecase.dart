import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/competition_detail_entity.dart';
import '../repositories/competition_detail_repository.dart';

class GetCompetitionDetailUseCase
    implements UseCase<CompetitionDetailEntity, String> {
  final CompetitionDetailRepository repository;

  GetCompetitionDetailUseCase(this.repository);

  @override
  Future<Either<Failure, CompetitionDetailEntity>> call(String id) async {
    return await repository.getCompetitionDetail(id);
  }
}
