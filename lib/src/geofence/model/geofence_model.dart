
class GeofenceModel{
  final bool inside;
  final String location;

  GeofenceModel({required this.inside, required this.location});

  factory GeofenceModel.fromJson(Map<String, dynamic> json) => GeofenceModel(
    inside: json['inside'],
    location: json['fence'] ?? "",
  );
}