import 'package:dartz/dartz.dart';
import 'package:flick_tv_ott/core/error/failure.dart';
import 'package:flick_tv_ott/domain/entities/experience_entity.dart';

abstract class ExperienceRepository {
  // Uses dartz's 'Either' to handle success (Right) or failure (Left)
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences();
}