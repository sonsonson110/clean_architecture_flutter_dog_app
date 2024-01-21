import 'package:clean_architecture_dog_app/features/daily_dogs/data/data_sources/remote/dog_api_service.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/data/repository/dog_repository_impl.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/repository/dog_repository.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/usecases/get_dogs.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<DogApiService>(DogApiService(sl()));

  sl.registerSingleton<DogRepository>(DogRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<GetDogsUseCase>(GetDogsUseCase(sl()));

  // Blocs shouldn't be registed as singleton
  sl.registerFactory<RemoteDogsBloc>(() => RemoteDogsBloc(sl()));
}
