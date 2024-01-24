import 'dart:developer';

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
                    itemCount: bloc.dogs.length,
                    itemBuilder: (context, index) {
                      return Image.network(bloc.dogs[index].url!);
                    }),
              ),
              const SizedBox(
                height: 8,
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
}
