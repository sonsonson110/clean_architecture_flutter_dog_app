import 'package:clean_architecture_dog_app/core/resources/data_state.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_dogs.dart';

class RemoteDogsBloc extends Bloc<RemoteDogsEvent, RemoteDogsState> {
  final GetDogsUseCase _getDogsUseCase;

  RemoteDogsBloc(this._getDogsUseCase) : super(const RemoteDogsLoading()) {
    on<GetDogs>(onGetDogs);
  }

  Future<void> onGetDogs(GetDogs event, Emitter<RemoteDogsState> emit) async {
    final dataState = await _getDogsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteDogsDone(dataState.data!));
    }
    if (dataState is DataFailed && dataState.data!.isNotEmpty) {
      emit(RemoteDogError(dataState.error!));
    }
  }
}
