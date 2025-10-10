import 'package:dartz/dartz.dart';
import 'package:flick_tv_ott/core/error/exeception.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/video_repository.dart';
import '../sources/local_json_data.dart';

class VideoRepositoryImpl implements VideoRepository {
  final LocalDataSource localDataSource;

  VideoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() async {
    try {
      final localVideos = await localDataSource.getVideos();
      return Right(localVideos);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}