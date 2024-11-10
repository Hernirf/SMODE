class VehicleLocationModel {
  final double? lat;
  final double? lon;

  const VehicleLocationModel({
    this.lat,
    this.lon,
  });

  factory VehicleLocationModel.fromJson(Map<String, dynamic> json) =>
      VehicleLocationModel(
        lat: json['lat'],
        lon: json['lon'],
      );
}
