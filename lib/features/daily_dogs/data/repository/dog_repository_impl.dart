import 'dart:developer';
import 'dart:io';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/local/dog_dao.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/remote/dog_api_service.dart';
import '../../domain/repository/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  final DogApiService _dogApiService;
  final DogDao _dogDao;

  DogRepositoryImpl(this._dogApiService, this._dogDao);

  @override
  Future<DataState<List<DogEntity>>> getNewDogs() async {
    try {
      final httpResponse =
          await _dogApiService.getNewDogs(apiKey: apiKey, limit: '4');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // map to entity
        return DataSuccess(
            httpResponse.data.map((e) => DogEntity.fromDogModel(e)).toList());
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      log(e.message);
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteDog(DogEntity dogEntity) {
    return _dogDao.deleteDog(DogModel.fromDogEntity(dogEntity));
  }

  @override
  Future<List<DogEntity>> getSavedDogs() async {
    return _dogDao.getAllDogs().then<List<DogEntity>>(
        (list) => list.map((e) => DogEntity.fromDogModel(e)).toList());
  }

  @override
  Future<void> saveDog(DogEntity dogEntity) {
    return _dogDao.saveDog(DogModel.fromDogEntity(dogEntity));
  }
}
