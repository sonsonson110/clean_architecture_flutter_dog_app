import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/breed.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/measurement.dart';
import 'package:equatable/equatable.dart';

class BreedEntity extends Equatable {
  final MeasurementEntity? weight;
  final MeasurementEntity? height;
  final int? id;
  final String? name;
  final String? bredFor;
  final String? breedGroup;
  final String? lifeSpan;
  final String? temperament;
  final String? origin;

  const BreedEntity(
      {this.weight,
      this.height,
      this.id,
      this.name,
      this.bredFor,
      this.breedGroup,
      this.lifeSpan,
      this.temperament,
      this.origin});

  factory BreedEntity.fromBreedModel(BreedModel model) {
    return BreedEntity(
      weight: MeasurementEntity.fromMeasurementModel(model.weight),
      height: MeasurementEntity.fromMeasurementModel(model.height),
      id: model.id,
      name: model.name,
      bredFor: model.bredFor,
      breedGroup: model.breedGroup,
      lifeSpan: model.lifeSpan,
      temperament: model.temperament,
      origin: model.origin,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, bredFor, breedGroup, lifeSpan, temperament, origin];

  @override
  String toString() {
    return 'BreedEntity {'
        ' id: $id,'
        ' name: $name,'
        ' bredFor: $bredFor,'
        ' breedGroup: $breedGroup,'
        ' lifeSpan: $lifeSpan,'
        ' temperament: $temperament,'
        ' origin: $origin,'
        ' weight: $weight,'
        ' height: $height'
        '}';
  }
}
