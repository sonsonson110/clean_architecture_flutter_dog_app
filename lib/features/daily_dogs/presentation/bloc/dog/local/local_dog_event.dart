import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:equatable/equatable.dart';

abstract class LocalDogsEvent extends Equatable {
  final DogEntity? dogEntity;
  const LocalDogsEvent({this.dogEntity});

  @override
  List<Object?> get props => [dogEntity!];
}

// get all saved dogs
class GetSavedDogs extends LocalDogsEvent {
  const GetSavedDogs();
}

// save a dog
class SaveDog extends LocalDogsEvent {
  const SaveDog(DogEntity dogEntity) : super(dogEntity: dogEntity);
}
