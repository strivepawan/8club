
import 'package:equatable/equatable.dart';
part of 'home_bloc.dart';
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchVideosEvent extends HomeEvent {}