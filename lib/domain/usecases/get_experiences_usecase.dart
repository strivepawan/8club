import 'package:dartz/dartz.dart';
import 'package:flick_tv_ott/core/error/failure.dart';
import 'package:flick_tv_ott/domain/entities/experience_entity.dart';
import 'package:flick_tv_ott/domain/repositories/experience_repository.dart';


class GetExperiencesUsecase {
  final ExperienceRepository repository;

  GetExperiencesUsecase(this.repository);

  Future<Either<Failure, List<ExperienceEntity>>> call() {
    return repository.getExperiences();
  }
}