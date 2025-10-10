import 'package:flick_tv_ott/presentation/screen/details_page.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/video_entity.dart';

class HeroBanner extends StatelessWidget {
  final VideoEntity featuredVideo;
  final List<VideoEntity> allVideos;

  const HeroBanner({
    super.key,
    required this.featuredVideo,
    required this.allVideos, 
  });

  @override
  Widget build(BuildContext context) {
    void navigateToDetails() {
      Navigator.of(context).pushNamed(
        DetailsPage.routeName,
        arguments: {
          'video': featuredVideo,
          'allVideos': allVideos,
        },
      );
    }

    return GestureDetector(
      onTap: navigateToDetails, // Make the whole banner tappable
      child: Stack(
        children: [
          Image.network(
            featuredVideo.thumbnailUrl,
            height: 450,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(height: 450, color: Colors.grey.shade900),
          ),
          Container(
            height: 450,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  // ignore: deprecated_member_use
                  AppColors.background.withOpacity(0.8),
                  AppColors.background,
                ],
                stops: const [0.0, 0.4, 0.8, 1.0],
              ),
            ),
          ),
        
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'HINDI & TAMIL',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  featuredVideo.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bollywood • Action & Adventure • Spy',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                      onPressed: navigateToDetails,
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                       style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('My List'),
                   
                      onPressed: navigateToDetails,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}