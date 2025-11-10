// import 'package:flick_tv_ott/core/theme/app.theme.dart';
// import 'package:flick_tv_ott/presentation/routes/app_routers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'core/constants/app_strings.dart';
// import 'data/repositories/video_repository_impl.dart';
// import 'data/sources/local_json_data.dart';
// import 'domain/usecases/get_videos_usecase.dart';
// import 'presentation/blocs/home/home_bloc.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localDataSource = LocalDataSourceImpl();
//     final videoRepository = VideoRepositoryImpl(localDataSource: localDataSource);
//     final getVideosUseCase = GetVideosUseCase(videoRepository);

//     return BlocProvider(
//       create: (context) => HomeBloc(getVideosUseCase: getVideosUseCase),
//       child: MaterialApp(
//         title: AppStrings.appTitle,
//         theme: AppTheme.darkTheme,
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: AppRouter.onGenerateRoute,
//       ),
//     );
//   }
// }

import 'package:flick_tv_ott/presentation/screen/experience_selection_page.dart';
import 'package:flick_tv_ott/presentation/screen/onboarding_question_page.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotspot Onboarding',
      // theme: AppTheme.lightTheme, // From core/theme/
      // darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        // '/': (context) => const ExperienceSelectionPage(),
                '/': (context) => const OnboardingQuestionPage(),

        // '/onboarding-question': (context) => const OnboardingQuestionPage(),
      },
    );
  }
}