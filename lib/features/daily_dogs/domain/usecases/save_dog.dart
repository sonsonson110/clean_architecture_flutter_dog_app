import 'package:clean_architecture_dog_app/core/usecase/usecase.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/repository/dog_repository.dart';

class SaveDogUseCase extends UseCase<bool, DogEntity> {
  final DogRepository _dogRepository;

  SaveDogUseCase(this._dogRepository);

  @override
  Future<bool> call({DogEntity? params}) {
    return _dogRepository.saveDog(params!);
  }
}
