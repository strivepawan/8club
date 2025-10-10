import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<VideoEntity>>> getVideos();
}