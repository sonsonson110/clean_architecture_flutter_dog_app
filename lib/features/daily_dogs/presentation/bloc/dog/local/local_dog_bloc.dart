import 'package:clean_architecture_dog_app/features/daily_dogs/domain/usecases/get_saved_dogs.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/usecases/save_dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalDogBloc extends Bloc<LocalDogsEvent, LocalDogsState> {
  final GetSavedDogsUseCase _getSavedDogsUseCase;
  final SaveDogUseCase _saveDogUseCase;

  LocalDogBloc(this._getSavedDogsUseCase, this._saveDogUseCase)
      : super(const LocalDogsLoading()) {
    on<GetSavedDogs>(onGetSavedDogs);
    on<SaveDog>(onSaveDog);
  }

  void onGetSavedDogs(GetSavedDogs event, Emitter<LocalDogsState> emit) async {
    final dogs = await _getSavedDogsUseCase();
    emit(LocalDogsDone(dogs));
  }

  Future<bool> onSaveDog(SaveDog saveDog, Emitter<LocalDogsState> emit) async {
    final result = await _saveDogUseCase(params: saveDog.dogEntity);
    final dogs = await _getSavedDogsUseCase();
    emit(LocalDogsDone(dogs));
    return result;
  }
}
