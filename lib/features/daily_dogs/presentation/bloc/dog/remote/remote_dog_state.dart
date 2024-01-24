import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteDogsState extends Equatable {
  final List<DogEntity>? dogs;
  final DioError? error;
  final RemoteLoadingMore? loadingMore;
  final RemoteLoadMoreError? loadMoreError;

  const RemoteDogsState(
      {this.dogs, this.error, this.loadingMore, this.loadMoreError});

  @override
  List<Object?> get props => [dogs, error, loadMoreError, loadingMore];
}

// states of ui
class RemoteDogsLoading extends RemoteDogsState {
  const RemoteDogsLoading();
}

class RemoteDogsDone extends RemoteDogsState {
  const RemoteDogsDone({
    required super.dogs,
    super.loadingMore,
    super.loadMoreError,
  });
}

class RemoteDogsError extends RemoteDogsState {
  const RemoteDogsError(DioError error) : super(error: error);
}

class RemoteLoadingMore {}

class RemoteLoadMoreError {
  final DioError? error;
  const RemoteLoadMoreError(this.error);
}
