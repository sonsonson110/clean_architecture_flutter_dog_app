import '../../../../core/usecase/usecase.dart';
import '../entities/dog.dart';
import '../repository/dog_repository.dart';

class DeleteDogUseCase extends UseCase<void, DogEntity> {
  final DogRepository _dogRepository;

  DeleteDogUseCase(this._dogRepository);

  @override
  Future<void> call({DogEntity? params}) {
    return _dogRepository.deleteDog(params!);
  }
}