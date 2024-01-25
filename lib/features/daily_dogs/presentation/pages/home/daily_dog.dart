import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyDogs extends StatelessWidget {
  const DailyDogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text("Daily dogs"),
      actions: [
        GestureDetector(
          child: const Icon(Icons.bookmark),
          onTap: () => _navigateToSavedDogs(context),
        )
      ],
    );
  }

  _buildBody(BuildContext context) {
    final bloc = BlocProvider.of<RemoteDogsBloc>(context);
    return BlocBuilder<RemoteDogsBloc, RemoteDogsState>(
        builder: (context, state) {
      if (state is RemoteDogsLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is RemoteDogsError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteDogsDone) {
        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                state.loadingMore == null) {
              bloc.add(GetMoreDogs());
            }
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.dogs!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => _navigateToDogDetails(
                              context, state.dogs![index]),
                          child: CachedNetworkImage(
                              imageUrl: state.dogs![index].url!));
                    }),
              ),
              if (state.error != null) Text(state.error!.message),
              if (state.loadingMore != null) const CupertinoActivityIndicator(),
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }

  void _navigateToDogDetails(BuildContext context, DogEntity dogEntity) {
    Navigator.pushNamed(context, '/DogDetails', arguments: dogEntity);
  }

  void _navigateToSavedDogs(BuildContext context) {
    Navigator.pushNamed(context, '/SavedDogs');
  }
}
