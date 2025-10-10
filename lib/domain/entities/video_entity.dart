import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final String category;
  final int year;
  final String rating;
  final int seasons;

  const VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
    required this.year,
    required this.rating,
    required this.seasons,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnailUrl,
        videoUrl,
        category,
        year,
        rating,
        seasons,
      ];
}