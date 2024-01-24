import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/local/database_helper.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/breed.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:sqflite/sqflite.dart';

class DogDao {
  final DatabaseHelper _databaseHelper;
  DogDao(this._databaseHelper);

  static const qDogId = 'dog_id';
  static const qDogUrl = 'url';
  static const qDogWidth = 'width';
  static const qDogHeight = 'height';

  static const qBreedId = 'breed_id';
  static const qBreedName = 'breed_name';
  static const qBreedFor = 'breed_for';
  static const qBreedGroup = 'breed_group';
  static const qLifeSpan = 'life_span';
  static const qTemperament = 'temperament';
  static const qOrigin = 'origin';
  static const qWeightInMetric = 'weight_in_metric';
  static const qWeightInImperial = 'weight_in_imperial';
  static const qHeightInMetric = 'height_in_metric';
  static const qHeightInImperial = 'height_in_imperial';

  final String _selectAllDogsQuery = '''
    SELECT
      ${DogTable.tableName}.${DogTable.id} AS ${qDogId},
      ${DogTable.tableName}.${DogTable.url} AS ${qDogUrl},
      ${DogTable.tableName}.${DogTable.width} AS ${qDogWidth},
      ${DogTable.tableName}.${DogTable.height} AS ${qDogHeight},

      ${BreedTable.tableName}.${BreedTable.id} AS ${qBreedId},
      ${BreedTable.tableName}.${BreedTable.name} AS ${qBreedName},
      ${BreedTable.tableName}.${BreedTable.breedFor} AS ${qBreedFor},
      ${BreedTable.tableName}.${BreedTable.breedGroup} AS ${qBreedGroup},
      ${BreedTable.tableName}.${BreedTable.lifeSpan} AS ${qLifeSpan},
      ${BreedTable.tableName}.${BreedTable.temperament} AS ${qTemperament},
      ${BreedTable.tableName}.${BreedTable.origin} AS ${qOrigin},
      ${BreedTable.tableName}.${BreedTable.weightInMetric} AS ${qWeightInMetric},
      ${BreedTable.tableName}.${BreedTable.weightInImperial} AS ${qWeightInImperial},
      ${BreedTable.tableName}.${BreedTable.heightInMetric} AS ${qHeightInMetric},
      ${BreedTable.tableName}.${BreedTable.heightInImperial} AS ${qHeightInImperial}
    FROM
      ${DogTable.tableName}
    LEFT OUTER JOIN
      ${DogBreedTable.tableName} ON ${DogTable.tableName}.${DogTable.id} = ${DogBreedTable.tableName}.${DogBreedTable.dogId}
    LEFT OUTER JOIN
      ${BreedTable.tableName} ON ${DogBreedTable.tableName}.${DogBreedTable.breedId} = ${BreedTable.tableName}.${BreedTable.id};
  ''';

  Future<List<DogModel>> getAllDogs() async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db.rawQuery(_selectAllDogsQuery);
    // map to model
    List<DogModel> dogList = [];
    for (final curRecord in result) {
      final lastDog = dogList.isEmpty ? null : dogList[dogList.length - 1];
      if (lastDog == null || curRecord[qDogId] != lastDog.id) {
        dogList.add(DogModel.fromJson(curRecord));
      } else {
        lastDog.breeds!.add(BreedModel(
          id: curRecord[qBreedId],
          name: curRecord[qBreedName],
          bredFor: curRecord[qBreedFor],
          breedGroup: curRecord[qBreedGroup],
          lifeSpan: curRecord[qLifeSpan],
          temperament: curRecord[qTemperament],
          origin: curRecord[qOrigin],
        ));
      }
    }
    return dogList;
  }

  Future<bool> saveDog(DogModel dogModel) async {
    final db = await _databaseHelper.database;
    // insert dog table
    var dogResult = await db.insert(DogTable.tableName, dogModel.toDbDogMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
    if (dogResult == 0) throw Exception("Dog table insert failed");
    // insert breed table
    if (dogModel.breeds == null) return true;
    for (final breed in dogModel.breeds!) {
      var breedResult = await db.insert(
          BreedTable.tableName, breed.toDbBreedMap(),
          conflictAlgorithm: ConflictAlgorithm.abort);
      if (breedResult == 0) throw Exception("Breed table insert failed");
      // insert dog breed table
      var dogBreedResult =
          await db.insert(DogBreedTable.tableName, <String, dynamic>{
        DogBreedTable.dogId: dogModel.id,
        DogBreedTable.breedId: breed.id,
      });
      if (dogBreedResult == 0) throw Exception("Dog breed table insert failed");
    }
    return true;
  }
}
