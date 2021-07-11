import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tyba_test_daniel/src/models/restaurant_model.dart';

class RestaurantRepository {
  // final String _url = 'https://tyba-test-daniel-default-rtdb.firebaseio.com';

  Future<List<RestaurantModel>> getRestauransByQuery(String query) async {
    final String _url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyDC2N_kJq7lyxqhJKHLLDQ5BrJRgWGmDJg&query=$query&radius=10000';
    final res = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode(res.body);

    final List<RestaurantModel> restaurants = List();
    if (decodedData == null) return [];

    decodedData['results'].forEach((restaurant) {
      final restTemp = RestaurantModel.fromJson(restaurant);

      restaurants.add(restTemp);
    });

    return restaurants;
  }

  Future<List<RestaurantModel>> getRestauransByLocation(
      double latitud, double longitude) async {
    final String _url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitud,$longitude&rankby=distance&type=restaurant&key=AIzaSyDC2N_kJq7lyxqhJKHLLDQ5BrJRgWGmDJg';
    final res = await http.get(_url);

    final Map<String, dynamic> decodedData = json.decode(res.body);

    final List<RestaurantModel> restaurants = List();
    if (decodedData == null) return [];

    decodedData['results'].forEach((restaurant) {
      final restTemp = RestaurantModel.fromJson(restaurant);

      restaurants.add(restTemp);
    });

    return restaurants;
  }
}
