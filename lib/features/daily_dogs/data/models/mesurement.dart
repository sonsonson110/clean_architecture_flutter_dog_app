class MeasurementModel {
  String? imperial;
  String? metric;

  MeasurementModel({this.imperial, this.metric});

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    return MeasurementModel(imperial: json['imperial'], metric: json['metric']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imperial'] = imperial;
    data['metric'] = metric;
    return data;
  }
}
