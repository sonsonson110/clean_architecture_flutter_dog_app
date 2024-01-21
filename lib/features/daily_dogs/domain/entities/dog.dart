import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/breed.dart';
import 'package:equatable/equatable.dart';

class DogEntity extends Equatable {
  final List<BreedEntity>? breeds;
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  const DogEntity({this.breeds, this.id, this.url, this.width, this.height});

  @override
  List<Object?> get props => [id, url, width, height];

  factory DogEntity.fromDogModel(DogModel model) {
    return DogEntity(
        breeds:
            model.breeds?.map((e) => BreedEntity.fromBreedModel(e)).toList(),
        id: model.id,
        url: model.url,
        width: model.width,
        height: model.height);
  }

  @override
  String toString() {
    return 'DogEntity {'
        ' id: $id,'
        ' url: $url,'
        ' width: $width,'
        ' height: $height,'
        ' breeds: ${breedsToString()},'
        '}';
  }

  String breedsToString() {
    if (breeds == null || breeds!.isEmpty) {
      return '[]';
    }
    return '[${breeds!.map((breed) => breed.toString()).join(', ')}]';
  }
}
