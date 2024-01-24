import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:equatable/equatable.dart';

abstract class LocalDogsState extends Equatable {
  final List<DogEntity>? dogs;

  const LocalDogsState({this.dogs});

  @override
  List<Object?> get props => [dogs!];
}

class LocalDogsLoading extends LocalDogsState {
  const LocalDogsLoading();
}

class LocalDogsDone extends LocalDogsState {
  const LocalDogsDone(List<DogEntity> dogs) : super(dogs: dogs);
}
