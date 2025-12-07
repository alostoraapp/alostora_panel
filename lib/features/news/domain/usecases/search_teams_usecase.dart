import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/news/domain/entities/team_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';

class SearchTeamsUseCase implements UseCase<List<TeamEntity>, String> {
  final NewsRepository repository;

  SearchTeamsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TeamEntity>>> call(String query) async {
    return await repository.searchTeams(query);
  }
}
