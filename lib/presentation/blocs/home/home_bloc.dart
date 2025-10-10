import 'package:flick_tv_ott/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/video_entity.dart';
import '../../../domain/usecases/get_videos_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetVideosUseCase getVideosUseCase;

  HomeBloc({required this.getVideosUseCase}) : super(HomeInitial()) {
    on<FetchVideosEvent>((event, emit) async {
      emit(HomeLoading());
      final failureOrVideos = await getVideosUseCase();
      failureOrVideos.fold(
        (failure) => emit(HomeError(_mapFailureToMessage(failure))),
        (videos) {
          final categorized = <String, List<VideoEntity>>{};
          for (var video in videos) {
            (categorized[video.category] ??= []).add(video);
          }
          emit(HomeLoaded(categorized));
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return AppStrings.anErrorOccurred;
      case const (CacheFailure):
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}