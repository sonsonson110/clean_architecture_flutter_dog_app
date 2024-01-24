import 'dart:developer';

import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_dogs.dart';

class RemoteDogsBloc extends Bloc<RemoteDogsEvent, RemoteDogsState> {
  final GetDogsUseCase _getDogsUseCase;
  final List<DogEntity> dogs = [];
  final loadTriggerIndex = 2;

  RemoteDogsBloc(this._getDogsUseCase) : super(const RemoteDogsLoading()) {
    on<GetDogs>(onGetDogs);
    on<GetMoreDogs>(onGetMoreDogs);
  }

  Future<void> onGetDogs(GetDogs event, Emitter<RemoteDogsState> emit) async {
    log("Bloc/onGetDogs triggered");
    final dataState = await _getDogsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      dogs.addAll(dataState.data!);
      emit(RemoteDogsDone(dogs: dogs));
    }
    if (dataState is DataFailed) {
      log(dataState.error!.toString());
      emit(RemoteDogsError(dataState.error!));
    }
  }

  Future<void> onGetMoreDogs(
      GetMoreDogs event, Emitter<RemoteDogsState> emit) async {
    log("Bloc/onGetMoreDogs triggered");
    emit(RemoteDogsDone(dogs: dogs, loadingMore: RemoteLoadingMore()));
    final dataState = await _getDogsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      dogs.addAll(dataState.data!);
      emit(RemoteDogsDone(dogs: dogs));
    }
    if (dataState is DataFailed) {
      emit(RemoteDogsDone(
          dogs: dogs, loadMoreError: RemoteLoadMoreError(dataState.error)));
    }
  }
}
