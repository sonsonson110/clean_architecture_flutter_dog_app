import 'package:clean_architecture_dog_app/core/usecase/usecase.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/repository/dog_repository.dart';

class GetSavedDogsUseCase implements UseCase<List<DogEntity>, void> {
  final DogRepository _dogRepository;

  GetSavedDogsUseCase(this._dogRepository);

  @override
  Future<List<DogEntity>> call({void params}) {
    return _dogRepository.getSavedDogs();
  }
}
