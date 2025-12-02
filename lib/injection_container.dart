import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/config/constants.dart';
import 'core/presentation/cubit/language_cubit.dart';
import 'core/presentation/cubit/theme_cubit.dart';
import 'core/services/api_client.dart';
import 'core/services/app_interceptor.dart';
import 'core/services/in_memory_token_storage.dart';
import 'core/services/token_storage_service.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/check_status_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/refresh_token_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/match_detail/data/datasources/match_detail_remote_data_source.dart';
import 'features/match_detail/data/repositories/match_detail_repository_impl.dart';
import 'features/match_detail/domain/repositories/match_detail_repository.dart';
import 'features/match_detail/domain/usecases/get_lineup_usecase.dart';
import 'features/match_detail/domain/usecases/update_man_of_the_match.dart';
import 'features/match_detail/domain/usecases/get_match_incidents_usecase.dart';
import 'features/match_detail/domain/usecases/delete_incident_media_usecase.dart';
import 'features/match_detail/domain/usecases/update_incident_media_usecase.dart';
import 'features/match_detail/domain/usecases/approve_incident_media_usecase.dart';
import 'features/match_detail/presentation/bloc/lineup_bloc.dart';
import 'features/match_detail/presentation/bloc/match_incidents/match_incidents_bloc.dart';
import 'features/match_detail/presentation/bloc/match_highlights/match_highlights_bloc.dart';
import 'features/match_detail/domain/usecases/get_highlights_usecase.dart';
import 'features/match_detail/domain/usecases/create_highlight_usecase.dart';
import 'features/match_detail/domain/usecases/update_highlight_usecase.dart';
import 'features/match_detail/domain/usecases/delete_highlight_usecase.dart';
import 'features/match_detail/domain/usecases/approve_highlight_usecase.dart';
import 'features/match_detail/presentation/bloc/match_broadcasts/match_broadcasts_bloc.dart';
import 'features/match_detail/domain/usecases/get_broadcasts_usecase.dart';
import 'features/match_detail/domain/usecases/create_broadcast_usecase.dart';
import 'features/match_detail/domain/usecases/update_broadcast_usecase.dart';
import 'features/match_detail/domain/usecases/delete_broadcast_usecase.dart';
import 'features/match_detail/domain/usecases/search_tv_channels_usecase.dart';

import 'features/matches/data/datasources/matches_remote_datasource.dart';
import 'features/matches/data/repositories/matches_repository_impl.dart';
import 'features/matches/domain/repositories/matches_repository.dart';
import 'features/matches/domain/usecases/get_matches_usecase.dart';
import 'features/matches/presentation/bloc/matches_bloc.dart';
import 'features/settings/data/datasources/competition_config_remote_datasource.dart';
import 'features/settings/data/repositories/competition_config_repository_impl.dart';
import 'features/settings/domain/repositories/competition_config_repository.dart';
import 'features/settings/domain/usecases/add_competition_config_usecase.dart';
import 'features/settings/domain/usecases/delete_competition_config_usecase.dart';
import 'features/settings/domain/usecases/get_competition_configs_usecase.dart';
import 'features/settings/domain/usecases/reorder_competition_configs_usecase.dart';
import 'features/settings/domain/usecases/search_competitions_usecase.dart';
import 'features/settings/domain/usecases/toggle_competition_status_usecase.dart';
import 'features/settings/presentation/bloc/competition_config_bloc.dart';
import 'features/settings/presentation/bloc/search_competitions/search_competitions_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Features ---

  // Auth
  sl.registerLazySingleton(() => AuthBloc(
      loginUseCase: sl(), logoutUseCase: sl(), checkStatusUseCase: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckStatusUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(remoteDataSource: sl(), tokenStorageService: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // Matches
  sl.registerFactory(() => MatchesBloc(sl()));
  sl.registerLazySingleton(() => GetMatchesUseCase(sl()));
  sl.registerLazySingleton<MatchesRepository>(
      () => MatchesRepositoryImpl(sl()));
  sl.registerLazySingleton<MatchesRemoteDataSource>(
      () => MatchesRemoteDataSourceImpl(sl()));

  // Match Detail
  // Blocs
  sl.registerFactory(() => LineupBloc(
        getLineupUsecase: sl(),
        updateManOfTheMatch: sl(),
      ));
  sl.registerFactory(() => MatchIncidentsBloc(
        getMatchIncidentsUseCase: sl(),
        updateIncidentMediaUseCase: sl(),
        deleteIncidentMediaUseCase: sl(),
        approveIncidentMediaUseCase: sl(),
      ));
  sl.registerFactory(() => MatchHighlightsBloc(
        getHighlightsUseCase: sl(),
        createHighlightUseCase: sl(),
        updateHighlightUseCase: sl(),
        deleteHighlightUseCase: sl(),
        approveHighlightUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetLineupUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateManOfTheMatch(sl()));
  sl.registerLazySingleton(() => GetMatchIncidentsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateIncidentMediaUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIncidentMediaUseCase(sl()));
  sl.registerLazySingleton(() => ApproveIncidentMediaUseCase(sl()));

  // Highlights Use Cases
  sl.registerLazySingleton(() => GetHighlightsUseCase(sl()));
  sl.registerLazySingleton(() => CreateHighlightUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHighlightUseCase(sl()));
  sl.registerLazySingleton(() => DeleteHighlightUseCase(sl()));
  sl.registerLazySingleton(() => ApproveHighlightUseCase(sl()));

  // Broadcasts
  sl.registerFactory(() => MatchBroadcastsBloc(
        getBroadcastsUseCase: sl(),
        createBroadcastUseCase: sl(),
        updateBroadcastUseCase: sl(),
        deleteBroadcastUseCase: sl(),
      ));

  // Broadcasts Use Cases
  sl.registerLazySingleton(() => GetBroadcastsUseCase(sl()));
  sl.registerLazySingleton(() => CreateBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => SearchTvChannelsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<MatchDetailRepository>(
    () => MatchDetailRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MatchDetailRemoteDataSource>(
    () => MatchDetailRemoteDataSourceImpl(sl()),
  );

  // Settings (Competition Config)
  sl.registerFactory(() => CompetitionConfigBloc(
        getCompetitionConfigs: sl(),
        addCompetitionConfig: sl(),
        toggleCompetitionStatus: sl(),
        deleteCompetitionConfig: sl(),
        reorderCompetitionConfigs: sl(),
      ));
  sl.registerFactory(() => SearchCompetitionsBloc(sl()));
  sl.registerLazySingleton(() => GetCompetitionConfigsUseCase(sl()));
  sl.registerLazySingleton(() => AddCompetitionConfigUseCase(sl()));
  sl.registerLazySingleton(() => ToggleCompetitionStatusUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCompetitionConfigUseCase(sl()));
  sl.registerLazySingleton(() => ReorderCompetitionConfigsUseCase(sl()));
  sl.registerLazySingleton(() => SearchCompetitionsUseCase(sl()));

  sl.registerLazySingleton<CompetitionConfigRepository>(
      () => CompetitionConfigRepositoryImpl(sl()));
  sl.registerLazySingleton<CompetitionConfigRemoteDataSource>(
      () => CompetitionConfigRemoteDataSourceImpl(sl()));

  // --- Core ---
  sl.registerLazySingleton(() => ApiClient(sl()));

  if (kIsWeb) {
    sl.registerLazySingleton<TokenStorageService>(() => InMemoryTokenStorage());
  } else {
    sl.registerLazySingleton<TokenStorageService>(
        () => TokenStorageServiceImpl(sl()));
    sl.registerLazySingleton(() => const FlutterSecureStorage());
  }

  sl.registerLazySingleton(() => ThemeCubit());
  sl.registerLazySingleton(() => LanguageCubit(sl()));

  // External - Dio
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = AppConstants.baseUrl;
    if (kIsWeb) {
      dio.options.extra['withCredentials'] = true;
    }
    return dio;
  });

  sl.registerLazySingleton(() => AppInterceptor(sl()));
  sl.get<Dio>().interceptors.add(sl<AppInterceptor>());
}
