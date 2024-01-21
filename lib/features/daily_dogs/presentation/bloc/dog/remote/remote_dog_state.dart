import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteDogsState extends Equatable {
  final List<DogEntity>? dogs;
  final DioError? error;

  const RemoteDogsState({this.dogs, this.error});

  @override
  List<Object?> get props => [dogs!, error!];
}

// states of ui
class RemoteDogsLoading extends RemoteDogsState {
  const RemoteDogsLoading();
}

class RemoteDogsDone extends RemoteDogsState {
  const RemoteDogsDone(List<DogEntity> dogs) : super(dogs: dogs);
}

class RemoteDogsError extends RemoteDogsState {
  const RemoteDogsError(DioError error) : super(error: error);
}
