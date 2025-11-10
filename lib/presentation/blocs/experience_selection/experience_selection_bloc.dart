import 'package:bloc/bloc.dart';
import 'package:flick_tv_ott/domain/usecases/get_experiences_usecase.dart';

part 'experience_selection_event.dart';
part 'experience_selection_state.dart';

class ExperienceSelectionBloc
    extends Bloc<ExperienceSelectionEvent, ExperienceSelectionState> {
  final GetExperiencesUsecase getExperiences;

  ExperienceSelectionBloc({required this.getExperiences})
      : super(const ExperienceSelectionState()) {
    on<FetchExperiences>(_onFetchExperiences);
    on<ToggleExperienceSelection>(_onToggleExperienceSelection);
    on<UpdateDescription>(_onUpdateDescription);
  }

  Future<void> _onFetchExperiences(
    FetchExperiences event,
    Emitter<ExperienceSelectionState> emit,
  ) async {
    emit(state.copyWith(status: ExperienceSelectionStatus.loading));
    final failureOrExperiences = await getExperiences();

    failureOrExperiences.fold(
      (failure) => emit(state.copyWith(
        status: ExperienceSelectionStatus.error,
        errorMessage: 'Failed to fetch experiences',
      )),
      (experiences) => emit(state.copyWith(
        status: ExperienceSelectionStatus.loaded,
        experiences: experiences,
      )),
    );
  }

  void _onToggleExperienceSelection(
    ToggleExperienceSelection event,
    Emitter<ExperienceSelectionState> emit,
  ) {
    // Create a new modifiable set from the current state
    final newSelectedIds = Set<int>.from(state.selectedExperienceIds);
    
    if (newSelectedIds.contains(event.experienceId)) {
      newSelectedIds.remove(event.experienceId);
    } else {
      newSelectedIds.add(event.experienceId);
    }
    
    emit(state.copyWith(selectedExperienceIds: newSelectedIds));
    
    // TODO: Implement animation logic (brownie point)
    // You might need to re-order the 'experiences' list here
    // and emit it as well.
  }

  void _onUpdateDescription(
    UpdateDescription event,
    Emitter<ExperienceSelectionState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }
}