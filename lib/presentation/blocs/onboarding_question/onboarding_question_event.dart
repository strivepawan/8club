import 'package:equatable/equatable.dart';
part of 'onboarding_question_bloc.dart';

abstract class OnboardingQuestionEvent extends Equatable {
  const OnboardingQuestionEvent();
  @override
  List<Object> get props => [];
}

class QuestionTextUpdated extends OnboardingQuestionEvent {
  final String text;
  const QuestionTextUpdated(this.text);
  @override
  List<Object> get props => [text];
}

class SaveAudioAnswer extends OnboardingQuestionEvent {
  final String path;
  const SaveAudioAnswer(this.path);
  @override
  List<Object> get props => [path];
}

class DeleteAudioAnswer extends OnboardingQuestionEvent {}

class SaveVideoAnswer extends OnboardingQuestionEvent {
  final String path;
  const SaveVideoAnswer(this.path);
  @override
  List<Object> get props => [path];
}

class DeleteVideoAnswer extends OnboardingQuestionEvent {}