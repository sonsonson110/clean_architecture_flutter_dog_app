import 'package:clean_architecture_dog_app/features/daily_dogs/domain/usecases/get_saved_dogs.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/usecases/save_dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/delete_dog.dart';

class LocalDogBloc extends Bloc<LocalDogsEvent, LocalDogsState> {
  final GetSavedDogsUseCase _getSavedDogsUseCase;
  final SaveDogUseCase _saveDogUseCase;
  final DeleteDogUseCase _deleteDogUseCase;

  LocalDogBloc(this._getSavedDogsUseCase, this._saveDogUseCase, this._deleteDogUseCase)
      : super(const LocalDogsLoading()) {
    on<GetSavedDogs>(onGetSavedDogs);
    on<SaveDog>(onSaveDog);
    on<DeleteDog>(onDeleteDog);
  }

  void onGetSavedDogs(GetSavedDogs event, Emitter<LocalDogsState> emit) async {
    final dogs = await _getSavedDogsUseCase();
    emit(LocalDogsDone(dogs));
  }

  Future<void> onSaveDog(SaveDog event, Emitter<LocalDogsState> emit) async {
    await _saveDogUseCase(params: event.dogEntity);
    final dogs = await _getSavedDogsUseCase();
    emit(LocalDogsDone(dogs));
  }

  Future<void> onDeleteDog(DeleteDog event, Emitter<LocalDogsState> emit) async {
    await _deleteDogUseCase(params: event.dogEntity);
    final dogs = await _getSavedDogsUseCase();
    emit(LocalDogsDone(dogs));
  }
}
