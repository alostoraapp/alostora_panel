import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/competition_detail_entity.dart';
import '../../domain/usecases/get_competition_detail_usecase.dart';
import '../../domain/usecases/update_competition_detail_usecase.dart';
import 'competition_detail_event.dart';
import 'competition_detail_state.dart';

class CompetitionDetailBloc
    extends Bloc<CompetitionDetailEvent, CompetitionDetailState> {
  final GetCompetitionDetailUseCase getCompetitionDetail;
  final UpdateCompetitionDetailUseCase updateCompetitionDetail;

  CompetitionDetailBloc({
    required this.getCompetitionDetail,
    required this.updateCompetitionDetail,
  }) : super(CompetitionDetailInitial()) {
    on<GetCompetitionDetailEvent>(_onGetCompetitionDetail);
    on<UpdateCompetitionDetailEvent>(_onUpdateCompetitionDetail);
  }

  Future<void> _onGetCompetitionDetail(
    GetCompetitionDetailEvent event,
    Emitter<CompetitionDetailState> emit,
  ) async {
    emit(CompetitionDetailLoading());
    final result = await getCompetitionDetail(event.competitionId);
    result.fold(
      (failure) => emit(CompetitionDetailError(message: failure.toString())),
      (competition) => emit(CompetitionDetailLoaded(competition: competition)),
    );
  }

  Future<void> _onUpdateCompetitionDetail(
    UpdateCompetitionDetailEvent event,
    Emitter<CompetitionDetailState> emit,
  ) async {
    CompetitionDetailEntity? currentCompetition;
    if (state is CompetitionDetailLoaded) {
      currentCompetition = (state as CompetitionDetailLoaded).competition;
    } else if (state is CompetitionDetailUpdated) {
      currentCompetition = (state as CompetitionDetailUpdated).competition;
    }

    emit(CompetitionDetailUpdating(competition: currentCompetition));
    final result = await updateCompetitionDetail(UpdateCompetitionDetailParams(
      id: event.competitionId,
      body: event.body,
    ));
    result.fold(
      (failure) =>
          emit(CompetitionDetailUpdateError(message: failure.toString())),
      (competition) => emit(CompetitionDetailUpdated(competition: competition)),
    );
  }
}
