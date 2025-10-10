import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/video_entity.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel extends VideoEntity {
  const VideoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.thumbnailUrl,
    required super.videoUrl,
    required super.category,
    required super.year,
    required super.rating,
    required super.seasons,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}