import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/competition_detail_entity.dart';
import '../repositories/competition_detail_repository.dart';

class UpdateCompetitionDetailUseCase
    implements UseCase<CompetitionDetailEntity, UpdateCompetitionDetailParams> {
  final CompetitionDetailRepository repository;

  UpdateCompetitionDetailUseCase(this.repository);

  @override
  Future<Either<Failure, CompetitionDetailEntity>> call(
      UpdateCompetitionDetailParams params) async {
    return await repository.updateCompetitionDetail(params.id, params.body);
  }
}

class UpdateCompetitionDetailParams extends Equatable {
  final String id;
  final Map<String, dynamic> body;

  const UpdateCompetitionDetailParams({required this.id, required this.body});

  @override
  List<Object?> get props => [id, body];
}
