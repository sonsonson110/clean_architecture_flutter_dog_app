import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_dog_app/core/features/injection_container.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_bloc.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/local/local_dog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogDetails extends StatelessWidget {
  final DogEntity dogEntity;
  const DogDetails({super.key, required this.dogEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalDogBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
        floatingActionButton: _buildFab(),
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
      title: const Text("Dog details"),
    );
  }

  _buildBody() {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: dogEntity.url!),
        Text(dogEntity.toString()),
      ],
    );
  }

  _buildFab() {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          onPressed: () => _onFabTapped(context),
          child: const Icon(Icons.bookmark_add),
        );
      },
    );
  }

  _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  _onFabTapped(BuildContext context) {
    BlocProvider.of<LocalDogBloc>(context).add(SaveDog(dogEntity));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Dog saved successfully.'),
      ),
    );
  }
}
