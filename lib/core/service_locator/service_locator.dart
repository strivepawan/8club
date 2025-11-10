import 'package:dio/dio.dart';
import 'package:flick_tv_ott/data/repositories/experience_repository_impl.dart';
import 'package:flick_tv_ott/data/sources/experience_remote_data_source.dart';
import 'package:flick_tv_ott/domain/repositories/experience_repository.dart';
import 'package:flick_tv_ott/domain/usecases/get_experiences_usecase.dart';
import 'package:flick_tv_ott/presentation/blocs/experience_selection/experience_selection_bloc.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance; // sl = Service Locator

void init() {
  // --- BLoCs ---
  // BLoCs are registered as 'factory' because they create a new instance
  // every time they are requested.
  sl.registerFactory(
    () => ExperienceSelectionBloc(getExperiences: sl()),
  );

  // --- UseCases ---
  // UseCases are registered as 'lazySingleton'
  sl.registerLazySingleton(() => GetExperiencesUsecase(sl()));

  // --- Repositories ---
  sl.registerLazySingleton<ExperienceRepository>(
    () => ExperienceRepositoryImpl(remoteDataSource: sl()),
  );

  // --- Data Sources ---
  sl.registerLazySingleton<ExperienceRemoteDataSource>(
    () => ExperienceRemoteDataSourceImpl(dio: sl()),
  );

  // --- External ---
  // Register Dio as a lazy singleton
  sl.registerLazySingleton(() => Dio());
}