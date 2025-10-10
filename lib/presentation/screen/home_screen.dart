import 'package:flick_tv_ott/presentation/widget/carousel_section.dart';
import 'package:flick_tv_ott/presentation/widget/hero_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../blocs/home/home_bloc.dart';


class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchVideosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://flicktv.in/logo.png'), // A placeholder logo
        ),
        title: const Text(AppStrings.appTitle),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final allVideos =
                state.categorizedVideos.values.expand((v) => v).toList();
            
            final featuredVideo = allVideos.isNotEmpty ? allVideos.first : null;

            return ListView(
              padding: EdgeInsets.zero, 
              children: [
                
                if (featuredVideo != null) 
                HeroBanner(
                    featuredVideo: featuredVideo,
                    allVideos: allVideos,
                  ),

                _buildFilterChips(),

                
                ...state.categorizedVideos.entries
                  .where((entry) => entry.key != 'Featured') 
                  .map((entry) {
                    return CarouselSection(
                      categoryTitle: entry.key,
                      videos: entry.value,
                      allVideos: allVideos,
                    );
                  },
                ),
              ],
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildChip('TV Shows'),
          const SizedBox(width: 12),
          _buildChip('Movies'),
          const SizedBox(width: 12),
          _buildChip('Categories'),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {},
      backgroundColor: Colors.grey.shade800,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}