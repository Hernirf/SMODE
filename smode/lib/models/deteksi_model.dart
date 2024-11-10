class DeteksiModel {
  final String? createdAt;
  final String? message;


  const DeteksiModel({
    this.createdAt,
    this.message,

  });

  factory DeteksiModel.fromJson(Map<String, dynamic> json) => DeteksiModel(
        createdAt: json['created_at'], message: json['message'], 
      );
}
