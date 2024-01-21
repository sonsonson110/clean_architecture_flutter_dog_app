import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyDogs extends StatelessWidget {
  const DailyDogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text("Daily dogs"),
    );
  }

  _buildBody() {
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
            return Column(
              children: [
                Image.network(state.dogs![index].url!),
                Text(state.dogs![index].toString())
              ],
            );
          },
          itemCount: state.dogs!.length,
        );
      }
      return const SizedBox();
    });
  }
}
