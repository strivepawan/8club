
import 'package:flick_tv_ott/domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.id,
    required super.name,
    required super.tagline,
    required super.imageUrl,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}