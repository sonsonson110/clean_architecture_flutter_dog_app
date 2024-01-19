import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';

abstract class DogRepository {
  Future<DataState<List<DogModel>>> getNewDogs();
}
