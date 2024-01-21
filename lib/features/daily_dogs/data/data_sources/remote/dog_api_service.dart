import 'dart:math';

import 'package:clean_architecture_dog_app/core/constants/constants.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/dog.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// run 'dart run build_runner build' after finish implement

// retrofit generates code
part 'dog_api_service.g.dart';

@RestApi(baseUrl: theDogApiBaseUrl)
abstract class DogApiService {
  // create a factory method accept dio as a parameter
  factory DogApiService(Dio dio) = _DogApiService;

  @GET('/images/search')
  Future<HttpResponse<List<DogModel>>> getNewDogs({
    @Query("limit") String? limit,
    @Query("api_key") String? apiKey,
  });
}
