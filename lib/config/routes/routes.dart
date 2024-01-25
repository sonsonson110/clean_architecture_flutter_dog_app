import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/pages/dog_detail/dog_details.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/pages/home/daily_dog.dart';
import 'package:clean_architecture_dog_app/features/daily_dogs/presentation/pages/saved_dog/saved_dog.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyDogs());
      case '/DogDetails':
        return _materialRoute(DogDetails(
          dogEntity: settings.arguments as DogEntity,
        ));
      case '/SavedDogs':
        return _materialRoute(const SavedDogs());
      default:
        return _materialRoute(const DailyDogs());
    }
  }

  static Route _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
