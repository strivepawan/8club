import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final int id;
  final String name;
  final String tagline;
  final String imageUrl;

  const ExperienceEntity({
    required this.id,
    required this.name,
    required this.tagline,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, tagline, imageUrl];
}