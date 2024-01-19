import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/mesurement.dart';

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
}
