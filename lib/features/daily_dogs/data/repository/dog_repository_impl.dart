import 'dart:html';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/remote/dog_api_service.dart';
import '../../domain/repository/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  final DogApiService _dogApiService;
  DogRepositoryImpl(this._dogApiService);

  @override
  Future<DataState<List<DogModel>>> getNewDogs() async {
    try {
      final httpResponse =
          await _dogApiService.getNewDogs(apiKey: apiKey, limit: '4');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
