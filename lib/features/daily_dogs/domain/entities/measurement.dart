import 'package:equatable/equatable.dart';

class MeasurementEntity extends Equatable {
  final String? imperial;
  final String? metric;

  const MeasurementEntity(this.imperial, this.metric);

  @override
  List<Object?> get props => [imperial, metric];
}
