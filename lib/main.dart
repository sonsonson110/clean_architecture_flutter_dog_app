import 'package:clean_architecture_dog_app/core/features/injection_container.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/pages/home/daily_dog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDogsBloc>(
      create: (context) => sl()..add(const GetDogs()),
      child: const MaterialApp(
        home: DailyDogs(),
      ),
    );
  }
}
