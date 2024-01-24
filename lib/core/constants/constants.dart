/* remote data source */
const String theDogApiBaseUrl = 'https://api.thedogapi.com/v1';
const String apiKey =
    'live_iUNkkFkBaDe0YLw1Fylsx0gXKJNFplvPMazxEZXkM5htv5sieXFr6FG2pgpRT3PP';

/* local data source */
const String databaseName = 'app_database.db';

// dog table
class DogTable {
  static const String tableName = 'dog';
  static const String id = 'id';
  static const String url = 'url';
  static const String width = 'width';
  static const String height = 'height';
}

// breed table
class BreedTable {
  static const String tableName = 'breed';
  static const String id = 'id';
  static const String name = 'name';
  static const String breedFor = 'bred_for';
  static const String breedGroup = 'breed_group';
  static const String lifeSpan = 'life_span';
  static const String temperament = 'temperament';
  static const String origin = 'origin';
  static const String weightInMetric = 'weight_in_metric';
  static const String weightInImperial = 'weight_in_imperial';
  static const String heightInMetric = 'height_in_metric';
  static const String heightInImperial = 'height_in_imperial';
}

// dog breed many to many relationship table
class DogBreedTable {
  static const String tableName = 'dog_breed';
  static const String dogId = 'dog_id';
  static const String breedId = 'breed_id';
}
