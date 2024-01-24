import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final String createDogTable = '''
    CREATE TABLE ${DogTable.tableName} (
      ${DogTable.id} TEXT PRIMARY KEY,
      ${DogTable.url} TEXT,
      ${DogTable.width} INTEGER,
      ${DogTable.height} INTEGER
    );
  ''';

  final String createBreedTable = '''
    CREATE TABLE ${BreedTable.tableName} (
      ${BreedTable.id} INTEGER PRIMARY KEY,
      ${BreedTable.name} TEXT,
      ${BreedTable.breedFor} TEXT,
      ${BreedTable.breedGroup} TEXT,
      ${BreedTable.lifeSpan} TEXT,
      ${BreedTable.temperament} TEXT,
      ${BreedTable.origin} TEXT,
      ${BreedTable.weightInMetric} TEXT,
      ${BreedTable.weightInImperial} TEXT,
      ${BreedTable.heightInMetric} TEXT,
      ${BreedTable.heightInImperial} TEXT
    );
  ''';

  final String createDogBreedTable = '''
    CREATE TABLE ${DogBreedTable.tableName} (
      ${DogBreedTable.dogId} TEXT,
      ${DogBreedTable.breedId} INTEGER,
      PRIMARY KEY (${DogBreedTable.dogId}, ${DogBreedTable.breedId}),
      FOREIGN KEY (${DogBreedTable.dogId}) REFERENCES ${DogTable.tableName} (${DogTable.id}) ON DELETE SET NULL,
      FOREIGN KEY (${DogBreedTable.breedId}) REFERENCES ${BreedTable.tableName} (${BreedTable.id}) ON DELETE SET NULL
    );
  ''';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentDirectory.path, databaseName);
    // create the database
    var database = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(createDogTable);
    await db.execute(createBreedTable);
    await db.execute(createDogBreedTable);
  }
}
