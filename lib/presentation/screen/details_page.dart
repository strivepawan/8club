// import 'package:flick_tv_ott/presentation/screen/player_screen.dart';
// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../domain/entities/video_entity.dart';

// class DetailsPage extends StatelessWidget {
//   static const routeName = '/details';
//   final VideoEntity video;
//   final List<VideoEntity> allVideos;

//   const DetailsPage({
//     super.key,
//     required this.video,
//     required this.allVideos,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Find the initial index for the player page
//     final initialPlayerIndex = allVideos.indexOf(video);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Image Section
//             _buildTopSection(context, video),

//             // Info and Buttons Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     video.title,
//                     style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildMetadataRow(video),
//                   const SizedBox(height: 16),
//                   _buildPlayButton(context, initialPlayerIndex),
//                   const SizedBox(height: 12),
//                   _buildDownloadButton(),
//                   const SizedBox(height: 16),
//                   Text(
//                     video.description,
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                   const SizedBox(height: 20),
//                   _buildActionButtons(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTopSection(BuildContext context, VideoEntity video) {
//     return Stack(
//       children: [
//         Image.network(
//           video.thumbnailUrl,
//           height: 300,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//         Container(
//           height: 300,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.transparent, AppColors.background.withOpacity(0.0), AppColors.background],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 40,
//           left: 10,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//       ],
//     );
//   }
  
//   Widget _buildMetadataRow(VideoEntity video) {
//     return Row(
//       children: [
//         Text(video.year.toString(), style: const TextStyle(color: Colors.grey)),
//         const SizedBox(width: 16),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade800,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(video.rating, style: const TextStyle(color: Colors.white)),
//         ),
//         const SizedBox(width: 16),
//         Text('${video.seasons} Seasons', style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }

//   Widget _buildPlayButton(BuildContext context, int initialIndex) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         minimumSize: const Size(double.infinity, 50),
//       ),
//       icon: const Icon(Icons.play_arrow, size: 28),
//       label: const Text('Play', style: TextStyle(fontSize: 16)),
//       onPressed: () {
//         Navigator.of(context).pushNamed(
//           PlayerPage.routeName,
//           arguments: {
//             'videos': allVideos,
//             'initialIndex': initialIndex,
//           },
//         );
//       },
//     );
//   }

//   Widget _buildDownloadButton() {
//      return OutlinedButton.icon(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.grey.shade900,
//         minimumSize: const Size(double.infinity, 50),
//         side: BorderSide(color: Colors.grey.shade800)
//       ),
//       icon: const Icon(Icons.download, size: 28),
//       label: const Text('Download', style: TextStyle(fontSize: 16)),
//       onPressed: () { /* Download logic here */ },
//     );
//   }
  
//   Widget _buildActionButtons() {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         _ActionButton(icon: Icons.add, label: 'My List'),
//         SizedBox(width: 30),
//         _ActionButton(icon: Icons.thumb_up_alt_outlined, label: 'Rate'),
//         SizedBox(width: 30),
//         _ActionButton(icon: Icons.share, label: 'Share'),
//       ],
//     );
//   }
// }

// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _ActionButton({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 28),
//         const SizedBox(height: 4),
//         Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//       ],
//     );
//   }
// }

import 'package:flick_tv_ott/presentation/screen/player_screen.dart';
import 'package:flick_tv_ott/presentation/widget/video_thumbnail.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/video_entity.dart';


class DetailsPage extends StatelessWidget {
  static const routeName = '/details';
  final VideoEntity video;
  final List<VideoEntity> allVideos;

  const DetailsPage({
    super.key,
    required this.video,
    required this.allVideos,
  });

  @override
  Widget build(BuildContext context) {
    // Filter the list to get recommendations (e.g., same category, not the same movie)
    final recommendations = allVideos
        .where((v) => v.category == video.category && v.id != video.id)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSection(context, video),
            _buildInfoAndActionsSection(context, video),
            _buildRecommendationsSection(context, recommendations),
          ],
        ),
      ),
    );
  }

  // --- Sub-widgets for clarity ---

  Widget _buildTopSection(BuildContext context, VideoEntity video) {
    return Stack(
      children: [
        Image.network(
          video.thumbnailUrl,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        // Gradient for play button visibility
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // ignore: deprecated_member_use
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                begin: Alignment.center,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        
        Positioned(
          top: 40,
          right: 10,
          child: IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.black54),
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoAndActionsSection(BuildContext context, VideoEntity video) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('79% Match', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              Text(video.year.toString(), style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 12),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), color: Colors.grey.shade800, child: Text(video.rating, style: const TextStyle(color: Colors.white))),
              const SizedBox(width: 12),
              // Text(video.duration, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play'),
            onPressed: () {
              Navigator.of(context).pushNamed(PlayerPage.routeName, arguments: {'videos': allVideos, 'initialIndex': allVideos.indexOf(video)});
            },
          ),
          const SizedBox(height: 8),
          // ElevatedButton.icon(
          //   style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade800, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
          //   icon: const Icon(Icons.download),
          //   label: const Text('Download'),
          //   onPressed: () {},
          // ),
          const SizedBox(height: 16),
          Text(video.description, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          const Text('Cast: Hrithik Roshan, NTR Jr., Kiara Advani...', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(icon: Icons.add, label: 'My List'),
              _ActionButton(icon: Icons.thumb_up_alt_outlined, label: 'Rate'),
              _ActionButton(icon: Icons.share, label: 'Share'),
              _ActionButton(icon: Icons.report, label: 'Reports'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection(BuildContext context, List<VideoEntity> recommendations) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'MORE LIKE THIS'),
              Tab(text: 'MORE DETAILS'),
            ],
            indicatorColor: Colors.red,
            labelColor: Colors.white,
          ),
          SizedBox(
            // ⭐️ Important: Define a height for the TabBarView
            // The height is calculated based on item aspect ratio and cross-axis count
            height: 200 * (recommendations.length / 3).ceil().toDouble(),
            child: TabBarView(
              children: [
                // "More Like This" Grid
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    // ⭐️ These two properties are crucial for nesting a grid in a scroll view
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3, // Same as our thumbnail
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: recommendations.length,
                    itemBuilder: (context, index) {
                      return VideoThumbnail(
                        video: recommendations[index],
                        allVideos: allVideos,
                      );
                    },
                  ),
                ),
                // "More Details" Placeholder
                const Center(child: Text('More details about cast, crew, etc.', style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Action button sub-widget from previous version
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}