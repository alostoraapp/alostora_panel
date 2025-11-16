
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/presentation/cubit/language_cubit.dart';
import 'core/presentation/cubit/theme_cubit.dart';
import 'core/services/app_interceptor.dart';
import 'core/services/in_memory_token_storage.dart';
import 'core/services/token_storage_service.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/check_status_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Service Locator instance
final sl = GetIt.instance;

Future<void> init() async {
  // --- Features ---

  // Auth
  // BLoC
  sl.registerLazySingleton(() => AuthBloc(
        loginUseCase: sl(),
        logoutUseCase: sl(),
        checkStatusUseCase: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckStatusUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        tokenStorageService: sl(),
      ));

  // DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // --- Core ---

  // Services (Conditional Injection)
  if (kIsWeb) {
    sl.registerLazySingleton<TokenStorageService>(() => InMemoryTokenStorage());
  } else {
    sl.registerLazySingleton<TokenStorageService>(
        () => TokenStorageServiceImpl(sl()));
    sl.registerLazySingleton(() => const FlutterSecureStorage());
  }

  // Cubits
  sl.registerLazySingleton(() => ThemeCubit());
  sl.registerLazySingleton(() => LanguageCubit());

  // External - Dio
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = 'http://localhost:8000/v1'; // Set base URL here

    if (kIsWeb) {
      dio.options.extra['withCredentials'] = true;
    }
    // The interceptor will be added AFTER it's registered to avoid circular dependency
    return dio;
  });

  // Register the interceptor and add it to Dio
  sl.registerLazySingleton(() => AppInterceptor(sl()));
  sl.get<Dio>().interceptors.add(sl<AppInterceptor>());
}
