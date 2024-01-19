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

  const BreedEntity(this.weight, this.height, this.id, this.name, this.bredFor,
      this.breedGroup, this.lifeSpan, this.temperament, this.origin);

  @override
  List<Object?> get props =>
      [id, name, bredFor, breedGroup, lifeSpan, temperament, origin];
}
