// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  videoUrl: json['videoUrl'] as String,
  category: json['category'] as String,
  year: (json['year'] as num).toInt(),
  rating: json['rating'] as String,
  seasons: (json['seasons'] as num).toInt(),
);

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'videoUrl': instance.videoUrl,
      'category': instance.category,
      'year': instance.year,
      'rating': instance.rating,
      'seasons': instance.seasons,
    };
