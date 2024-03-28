import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lat': lat,
        'lng': lng,
      };

  final double lat;
  final double lng;

  @override
  List<Object> get props => [lat, lng];
}
