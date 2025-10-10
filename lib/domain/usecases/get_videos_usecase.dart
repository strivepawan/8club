import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class GetVideosUseCase {
  final VideoRepository repository;

  GetVideosUseCase(this.repository);

  Future<Either<Failure, List<VideoEntity>>> call() async {
    return await repository.getVideos();
  }
}