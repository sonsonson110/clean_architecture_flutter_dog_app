import 'package:clean_architecture_dog_app/features/daily_dogs/domain/entities/measurement.dart';

class MeasurementModel {
  String? imperial;
  String? metric;

  MeasurementModel({this.imperial, this.metric});

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return MeasurementModel(imperial: json['imperial'], metric: json['metric']);
  }

  factory MeasurementModel.fromMeasurementEntity(
      MeasurementEntity? measurementEntity) {
    return MeasurementModel(
        imperial: measurementEntity?.imperial,
        metric: measurementEntity?.metric);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imperial'] = imperial;
    data['metric'] = metric;
    return data;
  }
}
