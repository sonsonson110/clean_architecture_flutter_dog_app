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
}
