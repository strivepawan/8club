import 'package:equatable/equatable.dart';
import 'package:flick_tv_ott/domain/entities/experience_entity.dart';

part of 'experience_selection_bloc.dart';


enum ExperienceSelectionStatus { initial, loading, loaded, error }

class ExperienceSelectionState extends Equatable {
  final ExperienceSelectionStatus status;
  final List<ExperienceEntity> experiences;
  final Set<int> selectedExperienceIds; // Use a Set for easy add/remove
  final String description;
  final String? errorMessage;

  const ExperienceSelectionState({
    this.status = ExperienceSelectionStatus.initial,
    this.experiences = const [],
    this.selectedExperienceIds = const {},
    this.description = '',
    this.errorMessage,
  });

  // copyWith helper to easily update state
  ExperienceSelectionState copyWith({
    ExperienceSelectionStatus? status,
    List<ExperienceEntity>? experiences,
    Set<int>? selectedExperienceIds,
    String? description,
    String? errorMessage,
  }) {
    return ExperienceSelectionState(
      status: status ?? this.status,
      experiences: experiences ?? this.experiences,
      selectedExperienceIds: selectedExperienceIds ?? this.selectedExperienceIds,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        experiences,
        selectedExperienceIds,
        description,
        errorMessage,
      ];
}