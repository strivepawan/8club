import 'package:flick_tv_ott/presentation/screen/bottom_navigation.dart';
import 'package:flick_tv_ott/presentation/screen/details_page.dart';
import 'package:flick_tv_ott/presentation/screen/home_screen.dart';
import 'package:flick_tv_ott/presentation/screen/player_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/video_entity.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());

      // Add the new route for DetailsPage
      case DetailsPage.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetailsPage(
            video: args['video'] as VideoEntity,
            allVideos: args['allVideos'] as List<VideoEntity>,
          ),
        );

      case PlayerPage.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PlayerPage(
            videos: args['videos'] as List<VideoEntity>,
            initialIndex: args['initialIndex'] as int,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}