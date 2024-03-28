import 'package:equatable/equatable.dart';
import 'package:places_api/src/models/models.dart';

class Geometry extends Equatable {
  const Geometry({
    required this.location,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'location': location,
      };

  final Location location;

  @override
  List<Object> get props => [location];
}
