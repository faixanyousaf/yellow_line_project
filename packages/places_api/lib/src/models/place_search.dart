import 'package:equatable/equatable.dart';

class PlaceSearch extends Equatable {
  PlaceSearch({
    required this.description,
    required this.placeId,
  });

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
      description: json.containsKey('name')
          ? json['name']
          : json['description'] as String,
      placeId: json['place_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'description': description,
        'place_id': placeId,
      };

  String description;
  final String placeId;

  @override
  List<Object> get props => [description, placeId];
}
