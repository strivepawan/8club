import 'package:equatable/equatable.dart';
import 'package:flick_tv_ott/domain/entities/video_entity.dart';

part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String, List<VideoEntity>> categorizedVideos;

  const HomeLoaded(this.categorizedVideos);

  @override
  List<Object> get props => [categorizedVideos];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}