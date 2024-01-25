import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/local/dog_dao.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/mesurement.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/breed.dart';

class BreedModel {
  MeasurementModel? weight;
  MeasurementModel? height;
  int? id;
  String? name;
  String? bredFor;
  String? breedGroup;
  String? lifeSpan;
  String? temperament;
  String? origin;
  String? referenceImageId;

  BreedModel(
      {this.weight,
      this.height,
      this.id,
      this.name,
      this.bredFor,
      this.breedGroup,
      this.lifeSpan,
      this.temperament,
      this.origin,
      this.referenceImageId});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
        weight: json['weight'] != null
            ? MeasurementModel.fromJson(json['weight'])
            : null,
        height: json['height'] != null
            ? MeasurementModel.fromJson(json['height'])
            : null,
        id: json['id'],
        name: json['name'],
        bredFor: json['bred_for'],
        breedGroup: json['temperament'],
        lifeSpan: json['life_span'],
        temperament: json['temperament'],
        origin: json['origin'],
        referenceImageId: json['reference_image_id']);
  }

  factory BreedModel.fromBreedEntity(BreedEntity breedEntity) {
    return BreedModel(
      weight: MeasurementModel.fromMeasurementEntity(breedEntity.weight),
      height: MeasurementModel.fromMeasurementEntity(breedEntity.height),
      id: breedEntity.id,
      name: breedEntity.name,
      bredFor: breedEntity.bredFor,
      breedGroup: breedEntity.breedGroup,
      lifeSpan: breedEntity.lifeSpan,
      temperament: breedEntity.temperament,
      origin: breedEntity.origin,
    );
  }

  factory BreedModel.fromDbMap(Map<String, dynamic> map) {
    return BreedModel(
      id: map[DogDao.qBreedId],
      name: map[DogDao.qBreedName],
      bredFor: map[DogDao.qBredFor],
      breedGroup: map[DogDao.qBreedGroup],
      lifeSpan: map[DogDao.qLifeSpan],
      temperament: map[DogDao.qTemperament],
      origin: map[DogDao.qOrigin],
      weight: MeasurementModel.fromDbMap(map, true),
      height: MeasurementModel.fromDbMap(map, false),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weight != null) {
      data['weight'] = weight!.toJson();
    }
    if (height != null) {
      data['height'] = height!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['bred_for'] = bredFor;
    data['breed_group'] = breedGroup;
    data['life_span'] = lifeSpan;
    data['temperament'] = temperament;
    data['origin'] = origin;
    data['reference_image_id'] = referenceImageId;
    return data;
  }

  Map<String, dynamic> toDbBreedMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weight != null) {
      data[BreedTable.weightInMetric] = weight!.metric;
      data[BreedTable.weightInImperial] = weight!.imperial;
    }
    if (height != null) {
      data[BreedTable.heightInMetric] = height!.metric;
      data[BreedTable.heightInImperial] = height!.imperial;
    }
    data[BreedTable.id] = id;
    data[BreedTable.name] = name;
    data[BreedTable.bredFor] = bredFor;
    data[BreedTable.breedGroup] = breedGroup;
    data[BreedTable.lifeSpan] = lifeSpan;
    data[BreedTable.temperament] = temperament;
    data[BreedTable.origin] = origin;
    // data['reference_image_id'] = referenceImageId;
    return data;
  }
}
