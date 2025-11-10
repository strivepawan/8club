import 'package:dartz/dartz.dart';
import 'package:flick_tv_ott/core/error/exeception.dart';
import 'package:flick_tv_ott/core/error/failure.dart';
import 'package:flick_tv_ott/data/sources/experience_remote_data_source.dart';
import 'package:flick_tv_ott/domain/entities/experience_entity.dart';
import 'package:flick_tv_ott/domain/repositories/experience_repository.dart';


class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceRemoteDataSource remoteDataSource;
  // You could also add a NetworkInfo class here to check for connection

  ExperienceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences() async {
    // if (await networkInfo.isConnected) { // <-- Good practice
      try {
        final remoteExperiences = await remoteDataSource.getExperiences();
        return Right(remoteExperiences);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }
}