import 'package:flick_tv_ott/core/theme/app.theme.dart';
import 'package:flick_tv_ott/presentation/routes/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_strings.dart';
import 'data/repositories/video_repository_impl.dart';
import 'data/sources/local_json_data.dart';
import 'domain/usecases/get_videos_usecase.dart';
import 'presentation/blocs/home/home_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // For simplicity, we are creating instances here.
    // In a larger app, use a service locator like get_it.
    final localDataSource = LocalDataSourceImpl();
    final videoRepository = VideoRepositoryImpl(localDataSource: localDataSource);
    final getVideosUseCase = GetVideosUseCase(videoRepository);

    return BlocProvider(
      create: (context) => HomeBloc(getVideosUseCase: getVideosUseCase),
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}