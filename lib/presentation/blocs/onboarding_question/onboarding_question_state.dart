import 'package:equatable/equatable.dart';
part of 'onboarding_question_bloc.dart';

class OnboardingQuestionState extends Equatable {
  final String answerText;
  final String? audioFilePath;
  final String? videoFilePath;

  const OnboardingQuestionState({
    this.answerText = '',
    this.audioFilePath,
    this.videoFilePath,
  });

  // Check if assets are recorded
  bool get isAudioRecorded => audioFilePath != null && audioFilePath!.isNotEmpty;
  bool get isVideoRecorded => videoFilePath != null && videoFilePath!.isNotEmpty;

  OnboardingQuestionState copyWith({
    String? answerText,
    String? audioFilePath, // Allow null to be passed for deletion
    String? videoFilePath, // Allow null to be passed for deletion
  }) {
    return OnboardingQuestionState(
      answerText: answerText ?? this.answerText,
      audioFilePath: audioFilePath,
      videoFilePath: videoFilePath,
    );
  }

  @override
  List<Object?> get props => [answerText, audioFilePath, videoFilePath];
}