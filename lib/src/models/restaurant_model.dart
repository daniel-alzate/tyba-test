import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    this.id,
    this.name = '',
    this.score = 0,
  });

  String id;
  String name;
  double score;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["place_id"],
        name: json["name"],
        score: json["rating"] == null ? 0 : json["rating"].toDouble()
      );

  Map<String, dynamic> toJson() => {
        "place_id": id,
        "name": name,
        "rating": score,
      };

    String getRestaurantImage (url){
      final base = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$url&key=AIzaSyDC2N_kJq7lyxqhJKHLLDQ5BrJRgWGmDJg';
      return base;
    }
}
