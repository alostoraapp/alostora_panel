import 'package:alostora/core/error/failure.dart';
import 'package:alostora/core/usecase/usecase.dart';
import 'package:alostora/core/utils/either.dart';
import 'package:alostora/features/news/domain/entities/news_entity.dart';
import 'package:alostora/features/news/domain/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';

class UploadNewsImageUseCase
    implements UseCase<NewsImageEntity, UploadNewsImageParams> {
  final NewsRepository repository;

  UploadNewsImageUseCase(this.repository);

  @override
  Future<Either<Failure, NewsImageEntity>> call(
      UploadNewsImageParams params) async {
    return await repository.uploadNewsImage(params.id, params.image,
        onSendProgress: params.onSendProgress);
  }
}

class UploadNewsImageParams extends Equatable {
  final String id;
  final dynamic image;
  final void Function(int, int)? onSendProgress;

  const UploadNewsImageParams(
      {required this.id, required this.image, this.onSendProgress});

  @override
  List<Object?> get props => [id, image, onSendProgress];
}
