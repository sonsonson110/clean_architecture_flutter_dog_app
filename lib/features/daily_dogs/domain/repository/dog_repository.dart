import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';

abstract class DogRepository {
  // api methods
  Future<DataState<List<DogEntity>>> getNewDogs();

  // database methods
  Future<List<DogEntity>> getSavedDogs();

  Future<bool> saveDog(DogEntity dogEntity);

  Future<bool> deleteDog(DogEntity dogEntity);
}
