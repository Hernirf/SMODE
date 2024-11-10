class VehicleModel {
  final int? id;
  final String? merk;
  final String? plate;
  final String? image;
  final int? modeAman;
  final int? modeMesin;
  final int? modeHemat;

  const VehicleModel({
    this.id,
    this.merk,
    this.plate,
    this.image,
    this.modeAman,
    this.modeMesin,
    this.modeHemat,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json['id'],
        merk: json['merk'],
        plate: json['plate'],
        image: json['image'],
        modeAman: json['mode_aman'],
        modeMesin: json['mode_mesin'],
        modeHemat: json['mode_hemat'],
      );
}
