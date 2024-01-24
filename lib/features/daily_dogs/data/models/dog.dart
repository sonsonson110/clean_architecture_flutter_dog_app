import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/breed.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';

class DogModel {
  List<BreedModel>? breeds;
  String? id;
  String? url;
  int? width;
  int? height;

  DogModel({this.breeds, this.id, this.url, this.width, this.height});

  factory DogModel.fromJson(Map<String, dynamic> json) {
    List<BreedModel>? nBreeds;
    if (json['breeds'] != null) {
      nBreeds = <BreedModel>[];
      json['breeds'].forEach((v) {
        nBreeds!.add(BreedModel.fromJson(v));
      });
    }

    return DogModel(
      breeds: nBreeds,
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  factory DogModel.fromDogEntity(DogEntity dogEntity) {
    List<BreedModel>? breeds =
        dogEntity.breeds?.map((e) => BreedModel.fromBreedEntity(e)).toList();
    return DogModel(
      breeds: breeds,
      id: dogEntity.id,
      url: dogEntity.url,
      width: dogEntity.width,
      height: dogEntity.height,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (breeds != null) {
      data['breeds'] = breeds!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }

  Map<String, dynamic> toDbDogMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DogTable.id] = id;
    data[DogTable.url] = url;
    data[DogTable.width] = width;
    data[DogTable.height] = height;
    return data;
  }
}
