import 'package:equatable/equatable.dart';
part of 'experience_selection_bloc.dart';



abstract class ExperienceSelectionEvent extends Equatable {
  const ExperienceSelectionEvent();
  @override
  List<Object> get props => [];
}

// Event to fetch data from the API
class FetchExperiences extends ExperienceSelectionEvent {}

// Event when a user taps a card
class ToggleExperienceSelection extends ExperienceSelectionEvent {
  final int experienceId;
  const ToggleExperienceSelection(this.experienceId);
  @override
  List<Object> get props => [experienceId];
}

// Event when the text field changes
class UpdateDescription extends ExperienceSelectionEvent {
  final String description;
  const UpdateDescription(this.description);
  @override
  List<Object> get props => [description];
}