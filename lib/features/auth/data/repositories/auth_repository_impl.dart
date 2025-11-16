
import 'package:flutter/foundation.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../../../core/utils/either.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorageService tokenStorageService;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenStorageService,
  });

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      if (!kIsWeb) {
        final tokenModel = await remoteDataSource.login(email, password);
        await tokenStorageService.saveTokens(
          accessToken: tokenModel.access,
          refreshToken: tokenModel.refresh,
        );
      } else {
        await remoteDataSource.login(email, password);
      }
      return const Right(null);
    } on AppException catch (e) {
      return Left(AuthFailure(message: e.errorResponse.firstError));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (kIsWeb) {
        await remoteDataSource.logout();
      }
      await tokenStorageService.deleteAllTokens();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to clear tokens'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkStatus() async {
    try {
      if (kIsWeb) {
        await remoteDataSource.verifyToken();
        return const Right(true);
      } else {
        final token = await tokenStorageService.getAccessToken();
        return Right(token != null);
      }
    } catch (e) {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      // For mobile, we need the refresh token to send in the body
      final refreshToken = kIsWeb ? null : await tokenStorageService.getRefreshToken();
      
      // If refresh token is null on mobile, we can't refresh.
      if (!kIsWeb && refreshToken == null) {
        return const Left(AuthFailure(message: 'No refresh token available.'));
      }

      final tokenModel = await remoteDataSource.refreshToken(refreshToken);

      // On mobile, save the new tokens. On web, cookies are handled automatically.
      if (!kIsWeb) {
        await tokenStorageService.saveTokens(
          accessToken: tokenModel.access,
          refreshToken: tokenModel.refresh,
        );
      }
      return const Right(null);
    } catch (e) {
      // If refresh fails, it's an authentication failure.
      return Left(AuthFailure(message: 'Failed to refresh token.'));
    }
  }
}
