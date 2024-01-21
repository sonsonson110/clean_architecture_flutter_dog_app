import 'package:clean_architecture_dog_app/features/daily_dogs/data/models/mesurement.dart';
import 'package:equatable/equatable.dart';

class MeasurementEntity extends Equatable {
  final String? imperial;
  final String? metric;

  const MeasurementEntity({this.imperial, this.metric});

  @override
  List<Object?> get props => [imperial, metric];

  factory MeasurementEntity.fromMeasurementModel(MeasurementModel? model) {
    return MeasurementEntity(imperial: model?.imperial, metric: model?.metric);
  }

  @override
  String toString() {
    return 'MeasurementEntity {'
        ' imperial: $imperial,'
        ' metric: $metric,'
        '}';
  }
}
