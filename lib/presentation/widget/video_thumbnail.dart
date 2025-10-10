import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_tv_ott/presentation/screen/details_page.dart'; 
import 'package:flutter/material.dart';
import '../../domain/entities/video_entity.dart';

class VideoThumbnail extends StatelessWidget {
  final VideoEntity video;
  final List<VideoEntity> allVideos;

  const VideoThumbnail({
    super.key,
    required this.video,
    required this.allVideos,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          DetailsPage.routeName,
          arguments: {
            'video': video,
            'allVideos': allVideos,
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // ⭐️ 2. REPLACE Image.network WITH CachedNetworkImage
            AspectRatio(
              aspectRatio: 2 / 3,
              child: CachedNetworkImage(
                imageUrl: video.thumbnailUrl, // Use imageUrl property
                fit: BoxFit.cover,
                // Show a loading spinner while the image is downloading for the first time
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
                // Show an error icon if the image fails to load
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            
            // The rest of your code (gradient, title, logo) remains the same
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // ignore: deprecated_member_use
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    stops: const [0.0, 0.6],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                video.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  shadows: [
                     Shadow(blurRadius: 2.0, color: Colors.black),
                  ]
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}