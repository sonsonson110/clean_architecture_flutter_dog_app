import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/core/usecase/usecase.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/repository/dog_repository.dart';

class GetDogsUseCase implements UseCase<DataState<List<DogEntity>>, void> {
  final DogRepository _dogRepository;
  GetDogsUseCase(this._dogRepository);

  @override
  Future<DataState<List<DogEntity>>> call({void params}) {
    // TODO: convert from repository to dog entity
    throw UnimplementedError();
  }
}
