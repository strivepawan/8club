import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import '../../domain/entities/video_entity.dart';
import 'video_thumbnail.dart';

class CarouselSection extends StatelessWidget {
  final String categoryTitle;
  final List<VideoEntity> videos;
  final List<VideoEntity> allVideos;

  const CarouselSection({
    super.key,
    required this.categoryTitle,
    required this.videos,
    required this.allVideos,
  });

  @override
  Widget build(BuildContext context) {
    // We can still limit videos if we want, but it's optional
    final limitedVideos = videos.length > 10 ? videos.sublist(0, 10) : videos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            categoryTitle,
            style: AppStyles.heading.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // ⭐️ Using ListView with a fixed height and fixed-width children
        SizedBox(
          height: 180, // A good height for portrait thumbnails
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: limitedVideos.length,
            itemBuilder: (context, index) {
              final video = limitedVideos[index];
              return Padding(
                // This padding ensures the list starts from the edge correctly
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 8.0,
                  right: index == limitedVideos.length - 1 ? 16.0 : 0,
                ),
                // ⭐️ This SizedBox is the key: it gives each item a fixed width
                child: SizedBox(
                  width: 110, // A good width for a compact, dense list
                  child: VideoThumbnail(
                    video: video,
                    allVideos: allVideos,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}