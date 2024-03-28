import 'package:equatable/equatable.dart';
import 'package:places_api/src/models/models.dart';

class Place extends Equatable {
  const Place({
    required this.geometry,
    required this.name,
    required this.vicinity,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      name: json['name'] as String,
      vicinity: json['vicinity'] == null ? '' : json['vicinity'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'geometry': geometry,
        'name': name,
        'vicinity': vicinity,
      };

  final Geometry geometry;
  final String name;
  final String vicinity;

  @override
  List<Object> get props => [geometry, name, vicinity];
}
