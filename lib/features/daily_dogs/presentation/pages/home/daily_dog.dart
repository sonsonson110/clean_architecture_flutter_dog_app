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
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text("Daily dogs"),
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
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index == bloc.dogs.length - bloc.loadTriggerIndex) {
              bloc.add(GetMoreDogs(index: index));
            }
            return GestureDetector(
              child: Image.network(bloc.dogs[index].url!),
              onTap: () {/**TODO: Implement route */},
            );
          },
          itemCount: bloc.dogs.length,
        );
      }
      return const SizedBox();
    });
  }
}
