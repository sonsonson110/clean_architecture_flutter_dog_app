import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_dog_app/core/features/injection_container.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_bloc.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedDogs extends StatelessWidget {
  const SavedDogs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalDogBloc>()..add(const GetSavedDogs()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      title: const Text("Saved dogs"),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalDogBloc, LocalDogsState>(builder: (context, state) {
      if (state is LocalDogsLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is LocalDogsDone) {
        return _buildDogList(state.dogs!);
      }
      return const SizedBox();
    });
  }

  _buildDogList(List<DogEntity> dogs) {
    if (dogs.isEmpty) {
      return const Center(
        child: Text("It's empty here"),
      );
    }

    return ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CachedNetworkImage(imageUrl: dogs[index].url!),
              Text(dogs[index].toString()),
              TextButton(
                  onPressed: () => _onDeleteButtonPressed(context, dogs[index]),
                  child: const Text("Delete")),
            ],
          );
        });
  }

  _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  _onDeleteButtonPressed(BuildContext context, DogEntity dog) {
    BlocProvider.of<LocalDogBloc>(context).add(DeleteDog(dog));
  }
}
