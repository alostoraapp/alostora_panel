import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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
import 'features/settings/domain/usecases/toggle_competition_status_usecase.dart';
import 'features/settings/domain/usecases/search_competitions_usecase.dart';
import 'features/settings/presentation/bloc/competition_config_bloc.dart';
import 'features/settings/presentation/bloc/search_competitions/search_competitions_bloc.dart';
import 'core/config/constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Features ---

  // Auth
  sl.registerLazySingleton(() => AuthBloc(loginUseCase: sl(), logoutUseCase: sl(), checkStatusUseCase: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckStatusUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl(), tokenStorageService: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  // Matches
  sl.registerFactory(() => MatchesBloc(sl()));
  sl.registerLazySingleton(() => GetMatchesUseCase(sl()));
  sl.registerLazySingleton<MatchesRepository>(() => MatchesRepositoryImpl(sl()));
  sl.registerLazySingleton<MatchesRemoteDataSource>(() => MatchesRemoteDataSourceImpl(sl()));

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
  
  sl.registerLazySingleton<CompetitionConfigRepository>(() => CompetitionConfigRepositoryImpl(sl()));
  sl.registerLazySingleton<CompetitionConfigRemoteDataSource>(() => CompetitionConfigRemoteDataSourceImpl(sl()));

  // --- Core ---
  sl.registerLazySingleton(() => ApiClient(sl()));

  if (kIsWeb) {
    sl.registerLazySingleton<TokenStorageService>(() => InMemoryTokenStorage());
  } else {
    sl.registerLazySingleton<TokenStorageService>(() => TokenStorageServiceImpl(sl()));
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
