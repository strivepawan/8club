
import 'package:bloc/bloc.dart';
import 'dart:io';

part 'onboarding_question_event.dart';
part 'onboarding_question_state.dart';

class OnboardingQuestionBloc
    extends Bloc<OnboardingQuestionEvent, OnboardingQuestionState> {
  OnboardingQuestionBloc() : super(const OnboardingQuestionState()) {
    on<QuestionTextUpdated>(_onQuestionTextUpdated);
    on<SaveAudioAnswer>(_onSaveAudioAnswer);
    on<DeleteAudioAnswer>(_onDeleteAudioAnswer);
    on<SaveVideoAnswer>(_onSaveVideoAnswer);
    on<DeleteVideoAnswer>(_onDeleteVideoAnswer);
  }

  void _onQuestionTextUpdated(
    QuestionTextUpdated event,
    Emitter<OnboardingQuestionState> emit,
  ) {
    emit(state.copyWith(answerText: event.text));
  }

  void _onSaveAudioAnswer(
    SaveAudioAnswer event,
    Emitter<OnboardingQuestionState> emit,
  ) {
    emit(state.copyWith(audioFilePath: event.path));
  }

  Future<void> _onDeleteAudioAnswer(
    DeleteAudioAnswer event,
    Emitter<OnboardingQuestionState> emit,
  ) async {
    if (state.audioFilePath != null) {
      final file = File(state.audioFilePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    emit(state.copyWith(audioFilePath: null));
  }

  void _onSaveVideoAnswer(
    SaveVideoAnswer event,
    Emitter<OnboardingQuestionState> emit,
  ) {
    emit(state.copyWith(videoFilePath: event.path));
  }

  Future<void> _onDeleteVideoAnswer(
    DeleteVideoAnswer event,
    Emitter<OnboardingQuestionState> emit,
  ) async {
    if (state.videoFilePath != null) {
      final file = File(state.videoFilePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    emit(state.copyWith(videoFilePath: null));
  }
}